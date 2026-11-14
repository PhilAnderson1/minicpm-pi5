// Build once against upstream headers/libraries and once with -DPI5_BENCH
// against minicpm-pi5. Run separately: never load both models concurrently.
#include <random>
#include "llama.h"
#include "llama-context.h"
#include "ggml-backend.h"
#include <chrono>
#include <cmath>
#include <cstdio>
#include <cstdlib>
#include <cstring>
#include <fstream>
#include <string>
#include <vector>
#include <sys/resource.h>
static void require(bool ok,const char *message) {
    if (!ok) { fprintf(stderr,"FAIL: %s\n",message); exit(1); }
}
static void quiet(ggml_log_level level,const char *message,void *) {
    if (level>=GGML_LOG_LEVEL_WARN) fputs(message,stderr);
}
static long reading(const char *path) { std::ifstream f(path); long n=0; f>>n; return n; }
static int eval(llama_context *c,int pos,int n) {
    auto b=llama_batch_init(n,0,1); b.n_tokens=n;
    for (int i=0;i<n;i++) {
        b.token[i]=100+(uint32_t(pos+i)*2654435761u)%120000;
        b.pos[i]=pos+i; b.n_seq_id[i]=1; b.seq_id[i][0]=0; b.logits[i]=i==n-1;
    }
    int rc=llama_decode(c,b); llama_batch_free(b); llama_synchronize(c); return rc;
}
static size_t offset(llama_context *c,int layer,int token,int head) {
#ifdef PI5_BENCH
    return (size_t(head)*c->kv_self.rows(layer)+token)*128*sizeof(ggml_fp16_t);
#else
    (void)c; (void)layer;
    return (size_t(token)*256+head*128)*sizeof(ggml_fp16_t);
#endif
}
static void seed(llama_context *c,int count) {
    auto &kv=c->kv_self; llama_kv_cache_clear(c);
    std::vector<ggml_fp16_t> row(256);
    for (int l=0;l<42;l++) for (int kind=0;kind<2;kind++) {
        auto t=kind?kv.v_l[l]:kv.k_l[l];
        for (int token=0;token<count;token++) {
            for (int d=0;d<256;d++) row[d]=ggml_fp32_to_fp16(float(((token*17+d*13+l*7+kind*19)%127)-63)/256.f);
            for (int h=0;h<2;h++) ggml_backend_tensor_set(t,row.data()+h*128,offset(c,l,token,h),256);
        }
    }
    for (int i=0;i<count;i++) { kv.cells[i].pos=i; kv.cells[i].seq_id.insert(0); }
    kv.used=count; kv.head=count;
}
static std::vector<float> logits(llama_context *c,int vocab) {
    const auto *p=llama_get_logits_ith(c,-1);
    for (int i=0;i<vocab;i++) require(std::isfinite(p[i]),"finite logits");
    return {p,p+vocab};
}
static void write(FILE *f,const void *data,size_t bytes) { require(fwrite(data,1,bytes,f)==bytes,"write reference"); }
int main(int argc,char **argv) {
    if (argc!=3 || !strcmp(argv[1],"--help")) {
        fprintf(stderr,"Usage: prefill_compare MODEL OUTPUT_DIRECTORY\nDirectory must exist. Fixed 128-token batches at prefixes 0/1024/8192/15360/23552.\n");
        return argc==2 && !strcmp(argv[1],"--help")?0:2;
    }
    setbuf(stdout,nullptr); llama_log_set(quiet,nullptr); llama_backend_init();
    auto mp=llama_model_default_params(); mp.n_gpu_layers=0; mp.repack_tensors=true; mp.use_mmap=false;
    auto m=llama_model_load_from_file(argv[1],mp); require(m,"model");
    const int vocab=llama_n_vocab(m),batch=128;
    puts("prefix_tokens,batch_tokens,seconds,tokens_per_second,major_faults,temp_mC,freq_kHz");
    for (int depth:{0,1024,8192,15360,23552}) {
        auto cp=llama_context_default_params(); cp.n_ctx=24576; cp.n_batch=2048; cp.n_ubatch=512;
        cp.n_threads=2; cp.n_threads_batch=4; cp.flash_attn=true; cp.graph_reuse=true;
        cp.type_k=cp.type_v=GGML_TYPE_F16; cp.defrag_thold=-1;
#ifdef PI5_BENCH
        cp.pi5_minicpm=true;
#endif
        auto c=llama_init_from_model(m,cp); require(c,"context"); seed(c,depth);
        require(!eval(c,depth,batch),"warmup"); auto reference=logits(c,vocab);
        require(llama_kv_cache_seq_rm(c,0,depth,-1),"truncate");
        rusage before{},after{}; getrusage(RUSAGE_SELF,&before);
        auto start=std::chrono::steady_clock::now(); require(!eval(c,depth,batch),"timed prefill");
        double seconds=std::chrono::duration<double>(std::chrono::steady_clock::now()-start).count();
        getrusage(RUSAGE_SELF,&after);
        printf("%d,%d,%.9f,%.9f,%ld,%ld,%ld\n",depth,batch,seconds,batch/seconds,
            after.ru_majflt-before.ru_majflt,reading("/sys/class/thermal/thermal_zone0/temp"),
            reading("/sys/devices/system/cpu/cpu0/cpufreq/scaling_cur_freq"));
        auto out=logits(c,vocab); require(out==reference,"warmup/timed logits agree");
        std::string path=std::string(argv[2])+"/depth-"+std::to_string(depth)+".bin";
        FILE *f=fopen(path.c_str(),"wb"); require(f,"open reference"); write(f,out.data(),out.size()*sizeof(float));
        // Canonical order: layer, K/V, token, head, dimension.
        std::vector<ggml_fp16_t> row(256);
        for (int l=0;l<42;l++) for (int kind=0;kind<2;kind++) {
            auto t=kind?c->kv_self.v_l[l]:c->kv_self.k_l[l];
            for (int token=depth;token<depth+batch;token++) {
                for (int h=0;h<2;h++) ggml_backend_tensor_get(t,row.data()+h*128,offset(c,l,token,h),256);
                write(f,row.data(),row.size()*sizeof(ggml_fp16_t));
            }
        }
        for (int k=0;k<4;k++) {
            require(!eval(c,depth+batch+k,1),"following decode"); out=logits(c,vocab);
            write(f,out.data(),out.size()*sizeof(float));
        }
        require(!fclose(f),"close reference"); llama_free(c);
        fprintf(stderr,"PASS prefix %d: warmup repeat and finite logits\n",depth);
    }
    llama_free_model(m); llama_backend_free();
}

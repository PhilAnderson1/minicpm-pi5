#include <random>
#include <string>
#include <unistd.h>
#include <omp.h>
#include "llama.h"
#include "llama-context.h"
#include "ggml-backend.h"
#include <algorithm>
#include <cmath>
#include <cstdio>
#include <cstdlib>
#include <cstring>
#include <vector>
#include <sys/resource.h>
static void check(bool ok,const char *s){if(!ok){fprintf(stderr,"FAIL %s\n",s);exit(1);}}
static void quiet(ggml_log_level level,const char*msg,void*){if(level>=GGML_LOG_LEVEL_WARN)fputs(msg,stderr);}
static llama_context * context(llama_model *m,bool pi,int capacity){
 auto p=llama_context_default_params();p.n_ctx=capacity;p.n_batch=64;p.n_ubatch=64;
 p.n_threads=2;p.n_threads_batch=4;p.flash_attn=true;p.graph_reuse=true;
 p.type_k=p.type_v=GGML_TYPE_F16;p.pi5_minicpm=pi;p.defrag_thold=-1;
 auto c=llama_init_from_model(m,p);check(c,"context init");return c;
}
static int eval(llama_context*c,int pos,int n=1){
 auto b=llama_batch_init(n,0,1);b.n_tokens=n;
 for(int i=0;i<n;i++){b.token[i]=100+(uint32_t(pos+i)*2654435761u)%120000;b.pos[i]=pos+i;b.n_seq_id[i]=1;b.seq_id[i][0]=0;b.logits[i]=i==n-1;}
 int rc=llama_decode(c,b);llama_batch_free(b);llama_synchronize(c);return rc;
}
static std::vector<float> logits(llama_context*c,int v){auto p=llama_get_logits_ith(c,-1);return {p,p+v};}
static void same(const std::vector<float>&a,const std::vector<float>&b,const char *name){
 check(a.size()==b.size(),"logit sizes");size_t count=0;float mx=0;
 for(size_t i=0;i<a.size();i++){check(std::isfinite(a[i])&&std::isfinite(b[i]),"finite logits");count+=a[i]!=b[i];mx=std::max(mx,std::abs(a[i]-b[i]));}
 printf("%s: changed=%zu max_abs=%g\n",name,count,mx);fflush(stdout);check(!count,name);
}
static std::vector<uint8_t> save(llama_context*c){
 std::vector<uint8_t> s(llama_state_seq_get_size(c,0,0));check(llama_state_seq_get_data(c,s.data(),s.size(),0,0)==s.size(),"seq save");return s;
}
static void restore(llama_context*c,const std::vector<uint8_t>&s){check(llama_state_seq_set_data(c,s.data(),s.size(),0,0)==s.size(),"seq restore");}
static void paired(llama_context*a,llama_context*b,int pos,int v,const char *name){check(!eval(a,pos)&&!eval(b,pos),"paired decode");same(logits(a,v),logits(b,v),name);}
struct Abort {int count=0;int stop;int team=0;};
static bool abort_cb(void*p){auto&a=*(Abort*)p;a.team=omp_get_num_threads();return ++a.count==a.stop;}
// Synthetic finite cache tests exercise large capacities without requiring hours of prefill.
// Both layouts get identical canonical values; only physical placement differs.
static void seed(llama_context*c,int count){
 llama_kv_cache_clear(c);auto&kv=c->kv_self;std::vector<ggml_fp16_t> row(256);
 for(int l=0;l<42;l++)for(int kind=0;kind<2;kind++){
  auto t=kind?kv.v_l[l]:kv.k_l[l];
  for(int token=0;token<count;token++){
   for(int d=0;d<256;d++)row[d]=ggml_fp32_to_fp16(float(((token*17+d*13+l*7+kind*19)%127)-63)/256.f);
   if(c->cparams.pi5_minicpm)for(int h=0;h<2;h++)ggml_backend_tensor_set(t,row.data()+h*128,(size_t(h)*kv.rows(l)+token)*256,256);
   else ggml_backend_tensor_set(t,row.data(),size_t(token)*512,512);
  }
 }
 for(int i=0;i<count;i++){kv.cells[i].pos=i;kv.cells[i].seq_id.insert(0);}
 kv.used=count;kv.head=count;
}
int main(int argc,char**argv){
 if(argc<2 || !strcmp(argv[1],"--help")){fprintf(argc<2?stderr:stdout,"Usage: integration_test MODEL [short]\nRun with no server active. Full mode includes a temporary 1 GiB state roundtrip.\n");return argc<2?2:0;}
 check(argc==2 || (argc==3 && !strcmp(argv[2],"short")),"optional short argument");setbuf(stdout,nullptr);llama_log_set(quiet,nullptr);llama_backend_init();
 auto mp=llama_model_default_params();mp.n_gpu_layers=0;mp.repack_tensors=true;mp.use_mmap=false;
 auto m=llama_model_load_from_file(argv[1],mp);check(m,"load model");int v=llama_n_vocab(m);
 for (int bad=0;bad<4;bad++) {
  auto cp=llama_context_default_params();cp.pi5_minicpm=true;cp.n_threads=2;cp.n_threads_batch=4;
  if(bad==0)cp.n_seq_max=2;
  if(bad==1)cp.n_threads=1;
  if(bad==2)cp.flash_attn=false;
  if(bad==3)cp.type_k=GGML_TYPE_Q8_0;
  check(llama_init_from_model(m,cp)==nullptr,"reject unsupported profile configuration");
 }
 auto a=context(m,false,512),b=context(m,true,24576);
 for(int p=0;p<256;p+=64){check(!eval(a,p,64)&&!eval(b,p,64),"real prefill");same(logits(a,v),logits(b,v),"prefill");}
 auto s=save(a);check(s==save(b),"canonical cache bytes");restore(b,s);
 {
  std::vector<uint8_t> full(llama_state_get_size(b));
  check(llama_state_get_data(b,full.data(),full.size())==full.size(),"full state save");
  llama_kv_cache_clear(b);
  check(llama_state_set_data(b,full.data(),full.size())==full.size(),"full state restore");
 }
 paired(a,b,256,v,"cross-layout and full-state restore");
 for(auto c:{a,b}){check(llama_kv_cache_seq_rm(c,0,32,96),"remove middle");llama_kv_cache_seq_add(c,0,96,-1,-64);llama_kv_cache_update(c);}
 paired(a,b,193,v,"context shift");
 for(auto c:{a,b}){llama_kv_cache_defrag(c);llama_kv_cache_update(c);}
 check(save(a)==save(b),"defrag canonical bytes");paired(a,b,194,v,"defrag decode");
 s=save(b);restore(a,s);paired(a,b,195,v,"reverse-layout restore");
 for(int stop:{1,2,3,8,17,64,128,256}){
  auto before=save(b);Abort ab{0,stop};llama_set_abort_callback(b,abort_cb,&ab);
  check(eval(b,196)==-3,"abort status");check(ab.team==2,"short decode team");llama_set_abort_callback(b,nullptr,nullptr);
  check(save(b)==before,"abort retained cache");check(!eval(b,196),"abort recovery");
  restore(b,before);
 }
 {
  auto before=save(b);Abort ab{0,128};llama_set_abort_callback(b,abort_cb,&ab);
  check(eval(b,196,64)==-3,"prefill abort status");llama_set_abort_callback(b,nullptr,nullptr);
  check(save(b)==before,"prefill abort retained cache");
  check(!eval(a,196,64)&&!eval(b,196,64),"prefill recovery");same(logits(a,v),logits(b,v),"prefill cancellation recovery");
 }
 // Cancellation arriving while a shift is pending must not leave half-rotated K.
 for(auto c:{a,b}){check(llama_kv_cache_seq_rm(c,0,32,64),"pending shift removal");llama_kv_cache_seq_add(c,0,64,-1,-32);}
 llama_kv_cache_update(a);
 {Abort ab{0,1};llama_set_abort_callback(b,abort_cb,&ab);check(eval(b,228)==-3,"pending shift cancellation");llama_set_abort_callback(b,nullptr,nullptr);check(ab.count==1,"maintenance did not invoke abort callback");}
 check(save(a)==save(b),"pending shift cache preserved");paired(a,b,228,v,"pending shift cancellation recovery");
 puts("short-context cancellation passed");llama_free(a);llama_free(b);
 if(argc>2){llama_free_model(m);llama_backend_free();puts("PASS short tests");return 0;}
 // Same context/model state stays independent when generic and optimized contexts alternate.
 a=context(m,false,8704);b=context(m,true,8704);
 for(int depth:{4095,4096,8192}){
  seed(a,depth);seed(b,depth);paired(a,b,depth,v,"synthetic long decode");
  auto baseline=logits(a,v);llama_kv_cache_seq_rm(a,0,depth,-1);llama_kv_cache_seq_rm(b,0,depth,-1);
  for(int stop:{1,2,3,8,17,64,128,256}){
   Abort ab{0,stop};llama_set_abort_callback(b,abort_cb,&ab);check(eval(b,depth)==-3,"mixed abort status");check(ab.team==(depth<4096?2:4),"adaptive team threshold");
   llama_set_abort_callback(b,nullptr,nullptr);check(b->kv_self.used==uint32_t(depth),"mixed abort retained cells");
   check(!eval(b,depth),"mixed abort recovery");same(baseline,logits(b,v),"mixed cancellation recovery");llama_kv_cache_seq_rm(b,0,depth,-1);
  }
  if(depth==8192){
   // Exercise the context-owned prefill path after a long retained prefix,
   // including cancellation after earlier layers have already written KV.
   auto before=save(b);
   check(!eval(a,depth,64),"long generic prefill reference");auto expected=logits(a,v);
   for(int stop:{1,17,128}){
    restore(b,before);Abort ab{0,stop};llama_set_abort_callback(b,abort_cb,&ab);
    check(eval(b,depth,64)==-3,"long prefill abort status");
    llama_set_abort_callback(b,nullptr,nullptr);check(ab.team==4,"long prefill team");
    check(save(b)==before,"long prefill retained cache");
    check(!eval(b,depth,64),"long prefill recovery");
    same(expected,logits(b,v),"long prefill cancellation recovery");
   }
  }
 }
 llama_free(a);llama_free(b);
 // The file is private, unique and removed automatically after normal completion.
 struct TempState {
     std::string path;
     TempState() {
         const char *tmp=getenv("TMPDIR");
         std::string pattern=std::string(tmp?tmp:"/tmp")+"/minicpm-pi5-state-XXXXXX";
         std::vector<char> name(pattern.begin(),pattern.end());name.push_back(0);
         int fd=mkstemp(name.data());check(fd>=0,"temporary state file");close(fd);path=name.data();
     }
     ~TempState(){unlink(path.c_str());}
 } state_file;
 // 24K capacity: sequential contexts keep the reference comparison within 4 GiB.
 a=context(m,false,24576);seed(a,24544);check(!eval(a,24544),"24K reference decode");auto ref=logits(a,v);
 check(llama_state_seq_save_file(a,state_file.path.c_str(),0,nullptr,0)>0,"24K canonical file");llama_free(a);
 b=context(m,true,24576);size_t nt=0;
 check(llama_state_seq_load_file(b,state_file.path.c_str(),0,nullptr,0,&nt)>0,"24K cross-layout file restore");
 check(llama_kv_cache_seq_rm(b,0,24544,-1),"24K truncate");check(!eval(b,24544),"24K optimized decode");same(ref,logits(b,v),"24K logits");
 // Hold a nearly 1 GiB prompt-cache entry alongside live 24K KV and the model.
 auto cache=save(b);printf("24K saved prompt bytes=%zu\n",cache.size());restore(b,cache);
 check(llama_kv_cache_seq_rm(b,0,24544,-1),"24K restored truncate");check(!eval(b,24544),"24K restored decode");same(ref,logits(b,v),"24K in-memory cache roundtrip");
 rusage u{};getrusage(RUSAGE_SELF,&u);printf("PASS max_rss_KiB=%ld major_faults=%ld\n",u.ru_maxrss,u.ru_majflt);
 llama_free(b);llama_free_model(m);llama_backend_free();return 0;
}

#define main integration_main
#include "integration_test.cpp"
#undef main
#include <chrono>
static int number(const char *s,int lo,int hi) {
 char *end=nullptr;long n=strtol(s,&end,10);check(*s&&!*end&&n>=lo&&n<=hi,"numeric argument out of range");return n;
}
int main(int argc,char **argv) {
 if(argc<2 || !strcmp(argv[1],"--help")) {
  fprintf(argc<2?stderr:stdout,"Usage: prefill_check MODEL [PREFIX_TOKENS BATCH_TOKENS]\nDefaults: 8192 128. Prefix is synthetic; timing excludes seeding and checks.\n");return argc<2?2:0;
 }
 check(argc==2 || argc==4,"argument count");int depth=argc==4?number(argv[2],0,24575):8192;int batch=argc==4?number(argv[3],1,512):128;check(depth+batch<=24576,"context capacity");
 setbuf(stdout,nullptr);llama_log_set(quiet,nullptr);llama_backend_init();auto mp=llama_model_default_params();mp.n_gpu_layers=0;mp.repack_tensors=true;mp.use_mmap=false;
 auto m=llama_model_load_from_file(argv[1],mp);check(m,"model");auto cp=llama_context_default_params();cp.n_ctx=24576;cp.n_batch=2048;cp.n_ubatch=512;cp.n_threads=2;cp.n_threads_batch=4;cp.pi5_minicpm=true;cp.flash_attn=true;cp.graph_reuse=true;cp.type_k=cp.type_v=GGML_TYPE_F16;
 auto c=llama_init_from_model(m,cp);check(c,"context");seed(c,depth);check(!eval(c,depth,batch),"warmup");auto ref=logits(c,llama_n_vocab(m));
 puts("prefix_tokens,batch_tokens,rep,seconds,tokens_per_second,major_faults");
 for(int rep=0;rep<3;rep++) {
  check(llama_kv_cache_seq_rm(c,0,depth,-1),"truncate");rusage before{},after{};getrusage(RUSAGE_SELF,&before);auto start=std::chrono::steady_clock::now();check(!eval(c,depth,batch),"prefill");double seconds=std::chrono::duration<double>(std::chrono::steady_clock::now()-start).count();getrusage(RUSAGE_SELF,&after);
  auto out=logits(c,llama_n_vocab(m));check(out==ref,"repeat logits match");for(auto x:out)check(std::isfinite(x),"finite logits");
  printf("%d,%d,%d,%.6f,%.6f,%ld\n",depth,batch,rep,seconds,batch/seconds,after.ru_majflt-before.ru_majflt);
 }
 llama_free(c);llama_free_model(m);llama_backend_free();fprintf(stderr,"PASS repeat prefill logits match\n");
}

#define main integration_test_main
#include "integration_test.cpp"
#undef main
#include <chrono>
int main(int argc,char**argv){
 if(argc<2 || !strcmp(argv[1],"--help")){
  fprintf(argc<2?stderr:stdout,"Usage: decode-check MODEL [PREFIX_TOKENS ...]\nDefault: 8192. Example: decode-check MODEL 1024 15360\n");return argc<2?2:0;
 }
 std::vector<int> depths;
 for(int i=2;i<argc;i++){
  char *end=nullptr;long n=strtol(argv[i],&end,10);
  if(!*argv[i] || *end || n<1 || n>24500){fprintf(stderr,"Invalid prefix length: %s (expected 1..24500)\n",argv[i]);return 2;}
  depths.push_back(int(n));
 }
 if(depths.empty())depths.push_back(8192);
 setbuf(stdout,nullptr);llama_log_set(quiet,nullptr);llama_backend_init();
 auto mp=llama_model_default_params();mp.n_gpu_layers=0;mp.repack_tensors=true;mp.use_mmap=false;
 auto m=llama_model_load_from_file(argv[1],mp);check(m,"model");
 puts("prefix_tokens,rep,mode,tokens,seconds,tokens_per_second,major_faults");
 for(int depth:depths){
 // Keep the same 512-token capacity margin as the original 8K check.
 auto a=context(m,false,depth+512),b=context(m,true,depth+512);seed(a,depth);seed(b,depth);
 int v=llama_n_vocab(m);std::vector<std::vector<float>> reference(16);double total[2]={};

 for(int rep=0;rep<3;rep++)for(int order=0;order<2;order++){
  int mode=(rep+order)%2;auto c=mode?b:a;check(llama_kv_cache_seq_rm(c,0,depth,-1),"truncate");check(!eval(c,depth),"warmup");llama_kv_cache_seq_rm(c,0,depth,-1);
  struct rusage before{},after{};getrusage(RUSAGE_SELF,&before);
  double seconds=0;
  for(int t=0;t<16;t++){
   auto start=std::chrono::steady_clock::now();check(!eval(c,depth+t),"timed decode");seconds+=std::chrono::duration<double>(std::chrono::steady_clock::now()-start).count();
   auto out=logits(c,v);if(!mode&&rep==0)reference[t]=out;else check(out==reference[t],"timed logit parity");
  }
  total[mode]+=seconds;getrusage(RUSAGE_SELF,&after);printf("%d,%d,%s,16,%.6f,%.6f,%ld\n",depth,rep,mode?"pi5":"stock",seconds,16/seconds,after.ru_majflt-before.ru_majflt);fflush(stdout);
 }
 fprintf(stderr,"Synthetic %d-token decode check: stock %.4f t/s, Pi profile %.4f t/s, gain %.2f%%\n",depth,48/total[0],48/total[1],100*(total[0]/total[1]-1));
 llama_free(a);llama_free(b);
 }
 llama_free_model(m);llama_backend_free();
}

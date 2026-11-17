// Decode and prefill matrix used for the rc4 README refresh.
// Compile against each engine separately, defining PI5_BENCH for the candidate.
#define main old_main
#include "prefill_compare.cpp"
#undef main
#include <fcntl.h>
#include <unistd.h>
int main(int argc,char**argv){require(argc==3,"MODEL OUTDIR");setbuf(stdout,nullptr);llama_log_set(quiet,nullptr);llama_backend_init();auto mp=llama_model_default_params();mp.n_gpu_layers=0;mp.repack_tensors=true;mp.use_mmap=false;auto m=llama_model_load_from_file(argv[1],mp);require(m,"model");int fd=open(argv[1],O_RDONLY);require(fd>=0,"model fd");posix_fadvise(fd,0,0,POSIX_FADV_DONTNEED);close(fd);int vocab=llama_n_vocab(m);
puts("workload,prefix_tokens,tokens,seconds,tokens_per_second,major_faults,temp_mC,freq_kHz");
for(int kind=0;kind<2;kind++)for(int depth:{1024,8192,15360,23552}){
 const char*label=kind?"prefill":"decode";int batch=kind?128:1,steps=kind?1:64;
 auto cp=llama_context_default_params();cp.n_ctx=kind?24576:depth+512;cp.n_batch=kind?2048:64;cp.n_ubatch=kind?512:64;cp.n_threads=2;cp.n_threads_batch=4;cp.flash_attn=true;cp.graph_reuse=true;cp.type_k=cp.type_v=GGML_TYPE_F16;cp.defrag_thold=-1;
#ifdef PI5_BENCH
 cp.pi5_minicpm=true;
#endif
 auto c=llama_init_from_model(m,cp);require(c,"context");seed(c,depth);require(!eval(c,depth,batch),"warmup");auto first=logits(c,vocab);require(llama_kv_cache_seq_rm(c,0,depth,-1),"truncate");
 std::vector<float>outputs;outputs.reserve(size_t(vocab)*steps);double seconds=0;rusage before{},after{};getrusage(RUSAGE_SELF,&before);
 for(int step=0;step<steps;step++){auto start=std::chrono::steady_clock::now();require(!eval(c,depth+step*batch,batch),"timed eval");seconds+=std::chrono::duration<double>(std::chrono::steady_clock::now()-start).count();auto out=logits(c,vocab);if(!step)require(out==first,"warmup parity");outputs.insert(outputs.end(),out.begin(),out.end());}
 getrusage(RUSAGE_SELF,&after);printf("%s,%d,%d,%.9f,%.9f,%ld,%ld,%ld\n",label,depth,batch*steps,seconds,batch*steps/seconds,after.ru_majflt-before.ru_majflt,reading("/sys/class/thermal/thermal_zone0/temp"),reading("/sys/devices/system/cpu/cpu0/cpufreq/scaling_cur_freq"));
 std::string path=std::string(argv[2])+"/"+label+"-"+std::to_string(depth)+".bin";FILE*f=fopen(path.c_str(),"wb");require(f,"output");write(f,outputs.data(),outputs.size()*4);fclose(f);llama_free(c);fprintf(stderr,"PASS %s %d\n",label,depth);
}llama_free_model(m);llama_backend_free();}

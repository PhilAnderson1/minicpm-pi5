// Compile against each engine as for prefill_compare.cpp; -DPI5_BENCH selects
// the optimized layout. Compare the output files from separate processes.
#define main prefill_compare_main
#include "prefill_compare.cpp"
#undef main
int main(int argc,char **argv) {
    if (argc!=3 || !strcmp(argv[1],"--help")) {
        fprintf(stderr,"Usage: decode_compare MODEL OUTPUT_FILE\n16 timed decode steps after 23,552 synthetic tokens.\n");
        return argc==2 && !strcmp(argv[1],"--help")?0:2;
    }
    setbuf(stdout,nullptr); llama_log_set(quiet,nullptr); llama_backend_init();
    auto mp=llama_model_default_params(); mp.n_gpu_layers=0; mp.repack_tensors=true; mp.use_mmap=false;
    auto m=llama_model_load_from_file(argv[1],mp); require(m,"model");
    const int depth=23552,count=16,vocab=llama_n_vocab(m);
    auto cp=llama_context_default_params(); cp.n_ctx=depth+512; cp.n_batch=64; cp.n_ubatch=64;
    cp.n_threads=2; cp.n_threads_batch=4; cp.flash_attn=true; cp.graph_reuse=true;
    cp.type_k=cp.type_v=GGML_TYPE_F16; cp.defrag_thold=-1;
#ifdef PI5_BENCH
    cp.pi5_minicpm=true;
#endif
    auto c=llama_init_from_model(m,cp); require(c,"context"); seed(c,depth);
    require(!eval(c,depth,1),"warmup"); auto first=logits(c,vocab);
    require(llama_kv_cache_seq_rm(c,0,depth,-1),"truncate");
    std::vector<std::vector<float>> outputs; outputs.reserve(count);
    rusage before{},after{}; getrusage(RUSAGE_SELF,&before); double seconds=0;
    for(int t=0;t<count;t++) {
        auto start=std::chrono::steady_clock::now(); require(!eval(c,depth+t,1),"timed decode");
        seconds+=std::chrono::duration<double>(std::chrono::steady_clock::now()-start).count();
        outputs.push_back(logits(c,vocab));
        if(t==0) require(outputs.back()==first,"warmup/timed logits agree");
    }
    getrusage(RUSAGE_SELF,&after);
    puts("prefix_tokens,tokens,seconds,tokens_per_second,major_faults,temp_mC,freq_kHz");
    printf("%d,%d,%.9f,%.9f,%ld,%ld,%ld\n",depth,count,seconds,count/seconds,
        after.ru_majflt-before.ru_majflt,reading("/sys/class/thermal/thermal_zone0/temp"),
        reading("/sys/devices/system/cpu/cpu0/cpufreq/scaling_cur_freq"));
    FILE *f=fopen(argv[2],"wb"); require(f,"open logits file");
    for(const auto &out:outputs) write(f,out.data(),out.size()*sizeof(float));
    require(!fclose(f),"close logits file");
    llama_free(c); llama_free_model(m); llama_backend_free();
    fputs("PASS warmup parity and finite logits\n",stderr);
}

// Compare prepared-tile dispatch against the unchanged eight-token Q4 kernel.
#include "iqk/iqk_gemm_kquants.h"
#include "iqk/iqk_mul_mat.h"
#include <algorithm>
#include <cmath>
#include <cstdio>
#include <cstdlib>
#include <cstring>
#include <random>
#include <vector>
#include <fcntl.h>
#include <sys/mman.h>
#include <sys/stat.h>
#include <unistd.h>
#include <omp.h>

static void check(bool ok, const char * message) {
    if (!ok) { fprintf(stderr, "FAIL %s\n", message); exit(1); }
}

int main(int argc, char ** argv) {
    check(argc == 2, "usage: q4_reuse_check MODEL");
    omp_set_dynamic(0);
    ggml_context * meta = nullptr;
    auto uf = gguf_init_from_file(argv[1], {true, &meta});
    check(uf && meta, "GGUF metadata");
    int fd = open(argv[1], O_RDONLY);
    struct stat st{};
    check(fd >= 0 && fstat(fd, &st) == 0, "model file");
    auto base = (uint8_t *)mmap(nullptr, st.st_size, PROT_READ, MAP_PRIVATE, fd, 0);
    check(base != MAP_FAILED, "model mapping");
    std::mt19937 rng(42);
    int cases = 0;
    for (auto name : {"blk.0.attn_k.weight", "blk.0.attn_q.weight", "blk.0.ffn_gate.weight", "blk.5.ffn_down.weight"}) {
        auto t = ggml_get_tensor(meta, name);
        check(t != nullptr, "model tensor");
        auto saved = *t;
        int idx = gguf_find_tensor(uf, name);
        check(idx >= 0, "tensor offset");
        int k = t->ne[0], m = t->ne[1];
        std::vector<uint8_t> packed(ggml_nbytes(t));
        memcpy(packed.data(), base + gguf_get_data_offset(uf) + gguf_get_tensor_offset(uf, idx), packed.size());
        t->data = packed.data();
        iqk_repack_tensor(t);
        check(t->type == GGML_TYPE_Q4_K_R4, "Q4 repacked tensor");
        auto qt = ggml_internal_get_type_traits(t->type).vec_dot_type;
        auto traits = ggml_internal_get_type_traits(qt);
        size_t stride = ggml_row_size(qt, k);
        std::array<mul_mat_t, IQK_MAX_NY> funcs{};
        mul_mat_t f16 = nullptr;
        check(iqk_set_kernels_kquants(k, t->type, qt, funcs, f16) && !f16, "original Q4 kernels");
        // Include the fast-path threshold, short fallbacks, full batches and tail groups.
        for (int batch : {8, 24, 64, 128, 136, 512, 520}) for (int pattern = 0; pattern < 5; ++pattern) {
            std::vector<float> input(size_t(k)*batch), expected(size_t(m)*batch), actual(expected.size());
            for (auto & v : input) {
                v = float(int(rng()%20001) - 10000)/10000.f;
                if (pattern == 0) v = 0;
                else if (pattern == 1) v *= 1e-6f;
                else if (pattern == 2) v *= 16.f;
                else if (pattern == 3) v = 0.125f;
            }
            std::vector<uint8_t> q(stride*batch);
            for (int y = 0; y < batch; ++y) traits.from_float(input.data() + size_t(y)*k, q.data() + stride*y, k);
            int ok = 1;
#pragma omp parallel num_threads(4) reduction(&:ok)
            {
                int id = omp_get_thread_num(), nth = omp_get_num_threads();
                int rows = 4*((m/4 + nth - 1)/nth), first = id*rows, last = std::min(m, first + rows);
                for (int x = first; x < last; x += 64) for (int y = 0; y < batch; y += 8) {
                    DataInfo info{expected.data() + x, (const char *)q.data(), size_t(m), stride, y, 1, nullptr, 0};
                    funcs[7](k, (const char *)t->data + size_t(x)*t->nb[1], t->nb[1], info, std::min(64, last - x));
                }
                ok &= iqk_mul_mat(m, batch, k, t->type, t->data, t->nb[1], qt, q.data(), stride, actual.data(), m, id, nth);
            }
            check(ok, "matrix dispatch");
            check(!memcmp(expected.data(), actual.data(), actual.size()*sizeof(float)), "exact original-kernel output");
            for (float v : actual) check(std::isfinite(v), "finite output");
            ++cases;
        }
        printf("PASS %s\n", name); fflush(stdout);
        *t = saved;
    }
    gguf_free(uf); ggml_free(meta); munmap(base, st.st_size); close(fd);
    printf("PASS %d exact Q4 matrix cases\n", cases);
}

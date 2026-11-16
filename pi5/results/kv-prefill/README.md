# KV-reuse prefill validation

The Pi prefill path shares each 128-key block across four query heads per
worker, with 64 query rows per head. FP16 KV and arithmetic order are retained.

Three alternating pairs at a synthetic 16K prefix measured incremental prefill
gains of 1.29% for 128 new tokens and 1.86% for 512. Raw CSVs are included.
The control used the original generic head schedule in the same process;
a test-only interposer selected each implementation. Both paths matched an
independent production reference. Timed calls had no major faults or process
swap. This small sample supersedes the earlier prototype's 7.3% estimate.
These results do not update the historical baseline comparison in the README.

Candidate validation included bitwise logits/KV comparisons, cancellation
recovery, irregular-shape fallback, and 24K state round trips. A full HTTP
run passed with 24,576 context and a 1 GiB prompt cache: real 24,500-token
prefill took 1,236.74 seconds overall (19.84 prompt tokens/s), and saved
long-prompt restoration took 3.35 seconds, evaluating one prompt token.
The HTTP run is functional validation, not a matched throughput comparison.
Its recorded binary/library hashes matched the locally validated candidate.

The clean package build is validated separately; candidate HTTP results alone
do not establish that a subsequently rebuilt package passes HTTP checks.

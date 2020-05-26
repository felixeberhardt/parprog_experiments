numactl --physcpubind=8-15 parallel --jobs 8 --timeout 40 --tag --lb ::: $@

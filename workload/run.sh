#!/bin/bash

numactl --physcpubind=8-15 perf stat -I 500 ./workload $@ 2> ./output.log

#watch -n 0.25 tail -n 11 ./output.log


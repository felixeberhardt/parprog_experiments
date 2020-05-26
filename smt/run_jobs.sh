#!/usr/bin/env bash

numactl --physcpubind=8-15 parallel --jobs 8 --timeout 4 --tag eval perf stat -e stalled-cycles-backend,instructions,cycles,r1001c,r1001c,r30006 -I 500 -x, < jobs.txt 2>&1 | sed -E 's/\s+/,/' | awk -F',' '!/stalled cycles per insn/{print $1, $3}' | sed -E 'N;N;N;N;N;s/\n(\w*) /,/g;s/ /,/' | awk -F',' '{print $0 "," $3 / $4}' | sed 's/,/\t/g'

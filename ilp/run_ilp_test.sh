#!/bin/bash
perf stat -I 500 $1 2> tmp.output

#open in a second terminal
#watch -n 0.1 tail -n 11 tmp.output

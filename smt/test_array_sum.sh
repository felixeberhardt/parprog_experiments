#!/bin/bash

./run_parallel.sh ../ilp/3_ilp_array_sum
read -p "continue?" -n 1
./run_parallel.sh ../ilp/3_ilp_array_sum ../ilp/3_ilp_array_sum
read -p "continue?" -n 1
./run_parallel.sh ../ilp/3_ilp_array_sum ../ilp/3_ilp_array_sum ../ilp/3_ilp_array_sum ../ilp/3_ilp_array_sum
read -p "continue?" -n 1
./run_parallel.sh ../ilp/3_ilp_array_sum ../ilp/3_ilp_array_sum ../ilp/3_ilp_array_sum ../ilp/3_ilp_array_sum ../ilp/3_ilp_array_sum ../ilp/3_ilp_array_sum ../ilp/3_ilp_array_sum ../ilp/3_ilp_array_sum

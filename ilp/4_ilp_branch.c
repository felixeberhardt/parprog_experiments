#include <stdlib.h>
#include <stdio.h>
#include <time.h>

#define ITERATIONS 10
#define ELEMENTS 100000000

void initialize(long *array) {
	srand(time(NULL));
	for(int i = 0; i < ELEMENTS; i++) {
		array[i] = rand() & 0x1;
	}
}

long array_branch_sum(long *array) {
	printf("########## Start Array Branch Sum ##########\n");
	volatile long sum = 0;
	asm volatile ("Start_Loop:");
	for(int iter; iter < ITERATIONS; iter++) {
		for(int i = 0; i < ELEMENTS - 3; i++) {
			if(array[i] == 1) {
				sum += array[i];
			}
		}
	}
	asm volatile ("End_Loop:");
	return sum;
}

int main() {
	long *array = (long *) malloc(sizeof(long) * ELEMENTS);
	initialize(array);
	long ret = array_branch_sum(array);
	return (int) ret;
}

#include <stdlib.h>
#include <stdio.h>
#include <time.h>

#define ITERATIONS 10
#define ELEMENTS 100000000

void initialize(long *array) {
	for(int i = 0; i < ELEMENTS; i++) {
		array[i] = i + 1;
	}
	array[ELEMENTS - 1] = 0;
}

long array_sum(long *array) {
	printf("########## Start Array Sum ##########\n");
	long sum = 0;
	asm volatile ("Start_Loop:");
	for(int iter; iter < ITERATIONS; iter++) {
		for(int i = 0; i < ELEMENTS - 3; i++) {
			sum += array[i] + 10 + array[i + 1] * 3 + array[i + 2] / 2 + array[i + 3] - 3; 
		}
	}
	asm volatile ("End_Loop:");
	return sum;
}

int main() {
	long *array = (long *) malloc(sizeof(long) * ELEMENTS);
	initialize(array);
	long ret = array_sum(array);
	return (int) ret;
}

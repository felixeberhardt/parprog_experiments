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

void shuffle(long *array) {
	srand((unsigned int)time(NULL));
	for(int i = ELEMENTS - 1; i >= 0; i--) {
		int r = rand() % (ELEMENTS - i);
		if(array[i] == r || array[r] == i) {
			continue;
		}
		if(array[array[i]] == r) {
			continue;
		}
		long tmp = array[i];
		array[i] = array[r];
		array[r] = tmp;
	}
}

long chase(long *array) {
	printf("########## Start Chasing ##########\n");
	long next = array[0];
	asm volatile ("Start_Loop:");
	for(int iter; iter < ITERATIONS; iter++) {
		for(int i = 0; i < ELEMENTS; i++) {
			next = array[next]; 
		}
	}
	asm volatile ("End_Loop:");
	return next;
}

int main() {
	if(RAND_MAX < ELEMENTS) {
		printf("ELEMENTS too large, maximal: %i!\n", RAND_MAX);
	}
	long *array = (long *) malloc(sizeof(long) * ELEMENTS);
	initialize(array);
	shuffle(array);
	long ret = chase(array);
	return (int) ret;
}

#define FTYPE float
#define FLIT(x) (x##f)
#define ITERATIONS 10000000000

int main() {
        volatile FTYPE acc = FLIT(1.0);
        asm volatile ("Start_Loop:");
	for(int i = 0; i < ITERATIONS; i++) {
                acc += (acc * i + acc + i);
        }
	asm volatile ("End_Loop:");
        return (int) acc;
}



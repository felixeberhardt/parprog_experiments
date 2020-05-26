#define FTYPE float
#define FLIT(x) (x##f)
#define ITERATIONS 10000000000

int main() {
  volatile FTYPE acc = FLIT(1.0);
  for(int i = 0; i < ITERATIONS; i++) {
	  acc += (acc * acc * i + acc * i);
  }
  return (int) acc;
}

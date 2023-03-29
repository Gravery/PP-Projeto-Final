CXX=gcc
CXXFLAGS= -O2 -Wall -fopenmp -pedantic

a.out: mergesort.c
	$(CXX) $(CXXFLAGS) mergesort.c

run:
	time ./a.out

clean:
	rm a.out

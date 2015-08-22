$CC=gcc
$CFLAGS=-Wall

.SUFFIXIES: .cpp .o _tests.c

tests: $(patsubst %,run_%,$(basename $(wildcard *_tests.c))) | clean

clean:
	rm -rf *.o *.tests

%.o : %.c
	$(CC) -g -O -c $(CFLAGS) $*.c -o $*.o

%_tests : %_tests.c %.o
	$(CC) -g $*.o  $*_tests.c $(CFLAGS) -o $*.tests

run_%_tests : %_tests
	./$*.tests
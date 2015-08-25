$CC=gcc
$CFLAGS=-Wall

.SUFFIXIES: .cpp .o _tests.c _tests

# By default build and run every *_tests.c file.

tests: $(patsubst %,run_%,$(basename $(wildcard *_tests.c))) | clean

clean:
	rm -rf *.o 
	rm -rf *_tests

%.o : %.c
	$(CC) -g -O -c $(CFLAGS) $< -o $@

%.o :
	ld -r $? -o $@

%_tests : %_tests.c %.o
	$(CC) -g $? $(CFLAGS) -o $@

run_%_tests : %_tests
	./$<


# Dependencies

check_partial_realisation.o : checking_part_a.o checking_part_b.o
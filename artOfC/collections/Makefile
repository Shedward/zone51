$CC=gcc
$CFLAGS=-Wall

.SUFFIXIES: .cpp .o .tests.c

clean:
	rm -rf *.o *.test *.bin

%.o : %.c
	$(CC) -g -O -c $(CFLAGS) $*.c -o $*.o

%.tests : %.tests.c %.o
	$(CC) $*.o  $*.tests.c $(CFLAGS) -o $*.tests
	./$*.tests
	rm $*.tests
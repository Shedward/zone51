$CFLAGS=-Wall -Wextra -std=c++11

.SUFFIXIES: .cpp .o

test: build 
	./calc

clean:
	rm -rf *.o
	rm calc

build: calc.cpp
	$(CXX) -g $? $(CFLAGS) -o calc

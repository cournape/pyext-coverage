CC	= clang
LD	= clang

#CFLAGS = -fPIC -W -Wall -Wextra --coverage -g
#LDFLAGS = --coverage -g
LDFLAGS = -Wall -fprofile-arcs -ftest-coverage --coverage
CFLAGS = -Xclang -coverage-cfg-checksum -Xclang -coverage-no-function-names-in-data -Xclang -coverage-version='407*' -fPIC --coverage

all: main

main: main.o libfoo.so
	$(CC) $(LDFLAGS) -o $@ main.o -L. -lfoo -Wl,-rpath,.

libfoo.so: foo.o
	$(CC) $(LDFLAGS) -o $@ $< -shared

.o: .c
	$(CC) $(CFLAGS) -o $@ $<

clean:
	rm -f main
	rm -f libfoo.so
	rm -f *.o
	rm -f *.gcda
	rm -f *.gcno
	rm -f *.*.gcov

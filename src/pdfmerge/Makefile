CC=clang
CFLAGS=-Weverything

install: pdfmerge 

pdfmerge: pdfmerge.c
	$(CC) -o ../../bin/pdfmerge pdfmerge.c

uninstall:
	rm -f ../../bin/pdfmerge

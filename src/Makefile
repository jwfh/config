all: fun
	find . -type d -depth 1 -exec make -C {} \;

fun:
	test -e `pwd`/../bin/kitty || ln -s `which cat` `pwd`/../bin/kitty
	test -e `pwd`/../bin/recycle || ln -s `which rm` `pwd`/../bin/recycle
	test -e `pwd`/../bin/compost || ln -s `which rm` `pwd`/../bin/compost

clean:
	rm -rf ../bin/*

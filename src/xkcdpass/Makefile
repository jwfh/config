all: .PHONY
	test -f `pwd`/../../bin/xkcdpass || (touch xkcdpass/setup.py && make xkcdpass)

install: xkcdpass

xkcdpass: xkcdpass/setup.py
	cd xkcdpass && python3 setup.py build
	test -d `pwd`/../../lib || mkdir `pwd`/../../lib
	cp -Rf xkcdpass/build/lib/xkcdpass `pwd`/../../lib/
	chmod u+x `pwd`/../../lib/xkcdpass/xkcd_password.py
	ln -s `pwd`/../../lib/xkcdpass/xkcd_password.py `pwd`/../../bin/xkcdpass

unisntall:
	rm -f `pwd`/../../bin/xkcdpass

.PHONY:

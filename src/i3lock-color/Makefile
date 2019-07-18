PREFIX?=	/usr/local
MANPREFIX?=	/usr/local
MAKE=		gmake

install: patch build do-install

all: i3lock

build: i3lock-color/i3lock.c 
	cd i3lock-color && env MAKE=$(MAKE) autoreconf --install \
		&& env MAKE=$(MAKE) ./configure \
		&& $(MAKE) -j`sysctl -n hw.ncpu` -C `./config.guess`

i3lock: .PHONY manpage
	make -C i3lock-color -f ../Makefile build
	cp i3lock-color/amd64-unknown-freebsd12.0/i3lock `pwd`/../../bin/i3lock
	sudo chown root `pwd`/../../bin/i3lock
	sudo chmod u+s `pwd`/../../bin/i3lock

manpage: i3lock-color/i3lock.1
	test -d `pwd`/../../man/man1 || mkdir -p `pwd`/../../man/man1
	cp i3lock-color/i3lock.1 `pwd`/../../man/man1/i3lock.1

clean: 
	rm -rf i3lock-color/`./i3lock-color/config.guess`

uninstall:
	rm -f `pwd`/../../bin/i3lock
	rm -f `pwd`/../../man/man1/i3lock.1

.PHONY:


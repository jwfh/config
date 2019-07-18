OS!=		uname -s
PREFIX?=	$(HOME)/config
DEST=		$(PREFIX)/bin

MACOS=	\
	andersonLectures \
	dictpass \
	fonts \
	fun \

warn:
	@printf "Run \`make %s\` to build." ${OS}

FreeBSD: \
	andersonLectures \
	dictpass \
	fonts \
	fun \
	i3lock-color \
	
macOS: $(MACOS)






andersonLectures dictpass fonts i3lock-color: .PHONY
	make PREFIX=$(PREFIX) -C $@ install

uninstall:
	rm -rf ../bin/*

clean:
	find . -type d -depth 1 -exec make -C {} clean \;

.PHONY:

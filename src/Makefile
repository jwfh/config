OS!=		uname -s
PREFIX?=	$(HOME)/config
DEST=		$(PREFIX)/bin

ALL=	\
	andersonLectures \
	dictpass \
	fonts \
	fun \
	i3lock-color \

FREEBSD=\
	andersonLectures \
	dictpass \
	fonts \
	fun \
	i3lock-color \


MACOS=	\
	andersonLectures \
	dictpass \
	fonts \
	fun \

warn:
	@printf "Run \`make %s\` to build." ${OS}

FreeBSD: $(FREEBSD)	
macOS: $(MACOS)
$(ALL): .PHONY
	make PREFIX=$(PREFIX) -C $@ install

uninstall:
	find . -type d -depth 1 -exec make -C {} uninstall \;

clean:
	find . -type d -depth 1 -exec make -C {} clean \;

.PHONY:

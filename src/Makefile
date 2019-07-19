OS!=		uname -s
PREFIX?=	${HOME}/config
DEST=		${PREFIX}/bin
PORTSDIR=	/usr/ports
PORTSTYPE!=	test -d ${PORTSDIR}/.svn && echo "SVN" || echo "PORTSNAP"

ALL=	\
	alacritty \
	andersonLectures \
	dictpass \
	fonts \
	fun \
	i3lock-color \

FREEBSD=\
	alacritty \
	andersonLectures \
	dictpass \
	fonts \
	fun \
	i3lock-color \


MACOS=	\
	alacritty \
	andersonLectures \
	dictpass \
	fonts \
	fun \

warn:
	@printf "Run \`make %s\` to build." ${OS}

FreeBSD: ports ${FREEBSD}	

macOS: ${MACOS}

${ALL}: .PHONY
	make PREFIX=${PREFIX} -C $@ install

ports: ${PORTSDIR}
.if ${PORTSTYPE} == "SVN"
	@echo "===> Detected svn(1) ports tree"
	@echo "===> Updating using \`svn up\`"
	@(cd ${PORTSDIR} && sudo svn up)
.else
	@echo "===> Detected portsnap(8) ports tree"
	@echo "===> Updating using \`portsnap fetch && portsnap extract\`"
	@(sudo portsnap fetch && sudo portsnap extract)
.endif

uninstall:
	find . -type d -depth 1 -exec make -C {} uninstall \;

clean:
	find . -type d -depth 1 -exec make -C {} clean \;

.PHONY:

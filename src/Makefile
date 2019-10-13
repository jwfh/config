OS!=		uname -s
PREFIX?=	/usr/local
DEST=		${PREFIX}/bin
PORTSDIR=	/usr/ports
PORTSTYPE!=	test -d ${PORTSDIR}/.svn && echo "SVN" || echo "PORTSNAP"

ALL=	\
	alacritty \
	andersonLectures \
	compton \
	cputemp \
	dictpass \
	findport \
	fonts \
	fun \
	i3lock-color \
	lesspipe \
	vscode \
	ssh \

FREEBSD=\
	findport \
	lesspipe \
	fun \
	vscode \
	cputemp \
	alacritty \
	andersonLectures \
	compton \
	dictpass \
	fonts \
	i3lock-color \

MACOS=	\
	alacritty \
	andersonLectures \
	dictpass \
	fonts \
	fun \
	lesspipe \
	ssh \

warn:
	@printf "Run \`make %s\` to build." ${OS}

FreeBSD: ports ${FREEBSD}	

macOS: ${MACOS}

.PHONY: ${ALL}
${ALL}: 
	@${MAKE} PREFIX=${PREFIX} -C $@ install

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

PREFIX?=	/usr/local
INSTALL_PROGRAM=install -s -m 555
INSTALL_LIB=	install -s -m 0644
INSTALL_SCRIPT=	install -m 555
INSTALL_DATA=	install -m 0644
INSTALL_MAN=	install -m 444
WRKSRC!=	pwd
DEST=		${PREFIX}/bin
LINKS= \
       		kitty \
		recycle \
		compost \
		bat
BAT!=		which bat
CAT!=		which cat
RM!=		which rm

install: ${LINKS:=-install}

uninstall: ${LINKS:=-uninstall}

bat-install: ${BAT}
	@printf "===> Linking script \`${@:-install=}\`\n"
	@${INSTALL_SCRIPT} -l sa ${BAT} ${DEST}/cat

kitty-install: ${CAT}
	@printf "===> Linking script \`${@:-install=}\`\n"
	@${INSTALL_SCRIPT} -l sa ${CAT} ${DEST}/kitty

recycle-install: ${RM}
	@printf "===> Linking script \`${@:-install=}\`\n"
	@${INSTALL_SCRIPT} -l sa ${RM} ${DEST}/recycle

compost-install: ${RM}
	@printf "===> Linking script \`${@:-install=}\`\n"
	@${INSTALL_SCRIPT} -l sa ${RM} ${DEST}/compost

${LINKS:=-uninstall}:
	@printf "===> Unlinking script \`${@:-uninstall=}\`\n"
	@rm -f ${DEST}/${@:-uninstall=} 

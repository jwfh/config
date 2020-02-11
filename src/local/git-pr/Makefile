PREFIX?=	/usr/local	
INSTALL_PROGRAM=install -s -m 555  
INSTALL_LIB=	install -s -m 0644
INSTALL_SCRIPT=	install -m 555
INSTALL_DATA=	install -m 0644
INSTALL_MAN=	install -m 444
WRKSRC!=	pwd
DEST=		${PREFIX}/bin

EXE=		npr

install: ${EXE:=-install}

uninstall:
	rm -f ${PREFIX}/bin/${EXE}

${EXE:=-install}:
	@printf "===> Linking script \`${@:-install=}\`\n"
	@${INSTALL_SCRIPT} ${WRKSRC}/${@:-install=} ${DEST}

${EXE:=-uninstall}:
	@printf "===> Unlinking script \`${@:-uninstall=}\`\n"
	@rm -f ${DEST}/${@:-uninstall=} 

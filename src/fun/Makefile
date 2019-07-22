PREFIX?=	/usr/local
DEST=		${PREFIX}/bin
LINKS= \
       		kitty \
		recycle \
		compost
CAT!=		which cat
RM!=		which rm

install: ${LINKS:=-install}

uninstall: ${LINKS:=-uninstall}

kitty-install:
	@printf "===> Linking script \`${@:-install=}\`\n"
	@test -f ${DEST}/kitty || ln -s ${CAT} ${DEST}/kitty

recycle-install:
	@printf "===> Linking script \`${@:-install=}\`\n"
	@test -f ${DEST}/recycle || ln -s ${RM} ${DEST}/recycle

compost-install:
	@printf "===> Linking script \`${@:-install=}\`\n"
	@test -f ${DEST}/compost || ln -s ${RM} ${DEST}/compost

${LINKS:=-uninstall}:
	@printf "===> Unlinking script \`${@:-uninstall=}\`\n"
	@rm -f ${DEST}/${@:-uninstall=} 

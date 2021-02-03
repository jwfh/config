.for SCRIPT in ${SCRIPT} ${SCRIPTS}
build: build.script.${SCRIPT}

install: install.script.${SCRIPT}

.if !target(build.script.${SCRIPT})
build.script.${SCRIPT}: ${SCRIPT}
.endif

.if !target(install.script.${SCRIPT})
install.script.${SCRIPT}: build.script.${SCRIPT}
	[ -d ${DESTDIR}${SCRIPTSDIR} ] || \
	${INSTALL} -d ${SCRIPTS_INSTALL_OWN} -m 775 ${DESTDIR}${BINDIR}
	${INSTALL} ${SCRIPTS_COPY} ${SCRIPTS_INSTALL_OWN} -m ${SCRIPTSMODE} \
		${SCRIPT} ${DESTDIR}${BINDIR}/${SCRIPT_NAME:U${SCRIPT:C/\..*$//}}
.endif

.endfor

.include "${.PARSEDIR}/config.commands.mk"
.MAIN: all

.include <bsd.prog.mk>

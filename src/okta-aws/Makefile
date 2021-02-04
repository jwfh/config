SCRIPTS=	awscli okta-credential_process okta-listroles withokta
DOTOKTA?=	${HOME}/.okta
LIBDIR?=	${DESTDIR}${PREFIX}/lib/okta
DECRYPT=	${:!(cd '${.CURDIR}/../gpghelper'; pwd -P)!}/decrypt.sh

EDITS=		${DOTOKTA}/config.properties

.for EDIT_FILE in ${EDITS}
.if defined(VERAFIN) && !empty(VERAFIN)
EDSCRIPT_${:!basename ${EDIT_FILE}!}=	verafin	
.else
EDSCRIPT_${:!basename ${EDIT_FILE}!}=	jwfh
.endif
.endfor

build:

install:
	[ -d '${LIBDIR}' ] || \
	${INSTALL} -d ${LIB_INSTALL_OWN} -m 775 ${LIBDIR}
	${INSTALL} ${LIB_COPY} ${LIB_INSTALL_OWN} -m ${NONBINMODE} \
		'${.CURDIR}/lib/okta-aws-cli-2.0.4.jar' '${LIBDIR}/okta-aws-cli.jar'
	[ -d '${DOTOKTA}' ] || \
		${INSTALL} -d ${LIB_INSTALL_OWN} -m 775 ${DOTOKTA}
.for file in logging.properties
	${INSTALL} ${LIB_COPY} ${LIB_INSTALL_OWN} -m ${NONBINMODE} \
		'${.CURDIR}/lib/${file}' '${DOTOKTA}/${file}'
.endfor
	[ -f '${DOTOKTA}/config.properties' ] || \
	${INSTALL} ${LIBCOPY} ${LIB_INSTALL_OWN} -m 640 \
		'${.CURDIR}/templates/config.properties.tpl' '${DOTOKTA}/config.properties'; \
	! ${GREP} -q -e 'PLACEHOLDER' '${DOTOKTA}/config.properties'  || \
	{ ${ECHO}; ${WARN} 'okta-aws configuration file ~/.okta/config.properties needs to be populated manually!'; ${ECHO}; }
	${MAKE} -C '${.CURDIR}' edit

.include "../Mk/config.commands.mk"
.include "../Mk/config.subdir.mk"
.include "../Mk/config.edit.mk"

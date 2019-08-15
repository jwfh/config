PKGS=		i3 i3-status dmenu rofi 
PORTS=		
OS!=		uname -s
FQDN!=		hostname -f
HOSTNAME=	${FQDN:C/\..*$//}
REPOCONFDIR=	${.CURDIR:C/[^\/]*\/[^\/]*$/.config/}
CONFFILE=	${REPOCONFDIR}/i3/config

MV!=		which mv
RM!=		which rm
RMARGS=		-f
ECHO!=		which echo
CAT!=		which cat
FIND!=		which find
TRUE!=		which true
FALSE!=		which false
SUDO!=		which sudo
TEST!=		which test
MAKE!=		which ${MAKE}

PREFIX?=	/usr/local
LOCALBUILDS!=	${FIND} "${.CURDIR:C/\/[^\/]*$//}" -type d -maxdepth 1 | xargs -n1 basename | sort
LOCALDEPS=		compton

dryrun:
	@${ECHO} "===> You must run \`${MAKE} -C ${.CURDIR} [makeconfig|install|uninstall]\`"
	@${FALSE}

install: check .PHONY ${OS}-install ${LOCALDEPS}
deinstall: check .PHONY ${OS}-deinstall

FreeBSD-install: .PHONY ${LOCALDEPS} ${PKGS:=-pkg} ${PORTS:=-port} 
FreeBSD-deinstall: .PHONY ${PKGS:=-rmpkg} ${PORTS:=-rmport} 

makeconfig: .PHONY ${CONFFILE}.base 
.if exists(${CONFFILE})
	@${ECHO} "===> Backing up existing i3 configuration at ${CONFFILE}"
	${MV} "${CONFFILE}" "${CONFFILE:=.bak}"
.else 
	@${ECHO} "===> No existing i3 configuration exists at ${CONFFILE}"
.endif
	@${ECHO} "===> Creating new i3 configuration file at ${CONFFILE}"

	@${ECHO} "  ===> Prefacing configuation file with global options"
	${CAT} ${CONFFILE}.base >> ${CONFFILE}

.if exists(${CONFFILE}.${HOSTNAME})
	@${ECHO} "  ===> Customizing with host-specific options for ${HOSTNAME:tu}"
	${CAT} "${CONFFILE}.${HOSTNAME}" >> "${CONFFILE}"
.else
	@${ECHO} "  ===> No host-specific options found for ${HOSTNAME:tu}"
.endif

check: 
.for DEP in ${LOCALDEPS}
DEPRULE=${LOCALBUILDS:M${DEP}}
.if empty(DEPRULE)
	@${ECHO} "===> No local build for ${DEP}"
	@${FALSE}
.endif
.endfor

${LOCALBUILDS}:
	@${ECHO} "===> Running local rule for ${.TARGET}"
	${MAKE} PREFIX=${PREFIX} -C ${.CURDIR:C/\/[^\/]*$//} ${.TARGET}

## We have no way using dependencies to determine whether a package/port has already 
## been installed. Hence all of the below targets require .PHONY as a dependency.
## pkg(1) and/or the Ports Makefiles have mechanisms to deal with an attempt to 
## install a package that has already been installed.

${PKGS:=-pkg}: .PHONY
	${SUDO} ${PKG} install -y ${.TARGET:-pkg=}

${PKGS:=-rm${PKG}}: .PHONY
	${SUDO} ${PKG} remove -y ${.TARGET:-pkg=}

${PORTS:=-port}: .PHONY
	${PORT} -i ${.TARGET:-port=}

${PORTS:=-rm${PORT}}: .PHONY
	${PORT} -d ${.TARGET:-rmport=}

.PHONY:

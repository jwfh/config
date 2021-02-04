BASENAME=	${:!command -v basename!}
COMMAND=	${:!command -v command!}
ECHO=		${:!command -v echo!}
ED=		${:!command -v ed!}
CAT=		${:!command -v cat!}
GIT=		${:!command -v git!}
GREP=		${:!command -v grep!} -E
MKDIR=		${:!command -v mkdir!} -p
LN=		${:!command -v ln!}
TAR=		${:!command -v tar!}
TOUCH=		${:!command -v touch!}
TPUT=		${:!command -v tput!}
ZIP=		${:!command -v zip!}
SH=		${:!command -v sh!}
INSTALL=	${:!command -v install!}

OS!=		uname -s
SHA_PROGRAM!=	which sha256sum 2>/dev/null || which sha256 2>/dev/null || echo $$(which shasum 2>/dev/null) -a 256

.if "${OS}" == Darwin
PKG!=		which brew
.elif "${OS}" == FreeBSD
PKG!=		which pkg
.else
.error Unsupported operating system ${OS}
.endif

PREFIX=	${HOME}/.local
BINDIR=	${PREFIX}/bin
MANDIR=	${PREFIX}/man

BINMODE?=	555
NONBINMODE?=	444
DIRMODE?=	755
MANMODE?=	${NONBINMODE}
LIBMODE?=	${NONBINMODE}
DOCMODE?=       ${NONBINMODE}
NLSMODE?=	${NONBINMODE}
KMODMODE?=	${NONBINMODE}
SHAREMODE?=	${NONBINMODE}

BINOWN!=	id -un
BINGRP!=	id -gn

SCRIPTSDIR?=	${BINDIR}
SCRIPTSOWN?=	${BINOWN}
SCRIPTSGRP?=	${BINGRP}
SCRIPTSMODE?=	${BINMODE}

PROG_INSTALL_OWN?= 	-o ${BINOWN} -g ${BINGRP}
LIB_INSTALL_OWN?= 	-o ${BINOWN} -g ${BINGRP}
SCRIPTS_INSTALL_OWN?= 	-o ${SCRIPTSOWN} -g ${SCRIPTSGRP}
LIB_COPY?= 		-C
SCRIPTS_COPY?= 		-C

str_RED!=	${TPUT} setaf 1
str_GREEN!=	${TPUT} setaf 2
str_YELLOW!=	${TPUT} setaf 3
str_NC!=	${TPUT} sgr0

INFO=	${ECHO} '${str_GREEN}INFO:${str_NC}'
WARN=	${ECHO} '${str_YELLOW}WARNING:${str_NC}'
ERROR=	${ECHO} '${str_RED}ERROR:${str_NC}'


REPO_ROOT!=	${GIT} rev-parse --show-toplevel

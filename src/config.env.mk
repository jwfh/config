.include "config.commands.mk"

ARCH!=		${UNAME} -p
OPSYS!=		${UNAME} -s
OSREL=		${:!${UNAME} -r!:C/-.*//}
HOSTNAME=	${:!${HOSTNAME_CMD}!:C/\..*$//}

LOCALBASE?=	/usr/local
PREFIX?=	${LOCALBASE}
MANPREFIX?=	${LOCALBASE}
LOCALDEPS?=	# User configurable
LOCALBUILDS!=	${FIND} "${.CURDIR}" -type d -maxdepth 1 \
		| ${XARGS} -n1 ${BASENAME} \
		| ${SORT} \
		| ${SED} -e 's/^/local-/'

MANDIRS+=	${MANPREFIX}/man
.for sect in 1 2 3 4 5 6 7 8 9
MAN${sect}PREFIX?=	${MANPREFIX}
.endfor
MANLPREFIX?=	${MANPREFIX}
MANNPREFIX?=	${MANPREFIX}
INFO_PATH?=	share/info

UID!=		${ID} -u
GID!=		${ID} -g

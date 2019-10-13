.if !defined(_COMMANDSMKINCLUDED)

_COMMANDSMKINCLUDED=	yes

AWK?=			/usr/bin/awk
BASENAME?=		/usr/bin/basename
BRANDELF?=		/usr/bin/brandelf
BSDMAKE?=		/usr/bin/make
BZCAT?=			/usr/bin/bzcat
BZIP2_CMD?=		/usr/bin/bzip2
CAT?=			/bin/cat
CHGRP?=			/usr/bin/chgrp
CHMOD?=			/bin/chmod
CHOWN?=			/usr/sbin/chown
CHROOT?=		/usr/sbin/chroot
COMM?=			/usr/bin/comm
CP?=			/bin/cp
CPIO?=			/usr/bin/cpio
CUT?=			/usr/bin/cut
DC?=			/usr/bin/dc
DIALOG?=		/usr/bin/dialog
DIALOG4PORTS?=		${LOCALBASE}/bin/dialog4ports
DIFF?=			/usr/bin/diff
DIRNAME?=		/usr/bin/dirname
EGREP?=			/usr/bin/egrep
EXPR?=			/bin/expr
FALSE?=			false	# Shell builtin
FETCH_BINARY?=		/usr/bin/fetch
FETCH_ARGS?=		-Fpr
FETCH_REGET?=		1
FETCH_CMD?=		${FETCH_BINARY} ${FETCH_ARGS}
FILE?=			/usr/bin/file
FIND?=			/usr/bin/find
FLEX?=			/usr/bin/flex
FMT?=			/usr/bin/fmt
FMT_80?=		${FMT} 75 79
GMAKE?=			gmake
GREP?=			/usr/bin/grep
GUNZIP_CMD?=		/usr/bin/gunzip -f
GZCAT?=			/usr/bin/gzcat
GZIP?=			-9
GZIP_CMD?=		/usr/bin/gzip -nf ${GZIP}
HEAD?=			/usr/bin/head
HOSTNAME_CMD?=		/bin/hostname -f
ID?=			/usr/bin/id
IDENT?=			/usr/bin/ident
JOT?=			/usr/bin/jot
LDCONFIG?=		/sbin/ldconfig
LHA_CMD?=		${LOCALBASE}/bin/lha
LN?=			/bin/ln
LS?=			/bin/ls
MKDIR?=			/bin/mkdir -p
MKTEMP?=		/usr/bin/mktemp
MOUNT?=			/sbin/mount
MOUNT_DEVFS?=		${MOUNT} -t devfs devfs
# XXX: this is a work-around for an obscure bug where
# mount -t nullfs returns zero status on errors within
# a make target
MOUNT_NULLFS?=		/sbin/mount_nullfs
MV?=			/bin/mv
OBJCOPY?=		/usr/bin/objcopy
OBJDUMP?=		/usr/bin/objdump
PASTE?=			/usr/bin/paste
PATCH?=			/usr/bin/patch

PAX?=			/bin/pax
PRINTF?=		/usr/bin/printf
PS_CMD?=		/bin/ps
PW?=			/usr/sbin/pw
READELF?=		/usr/bin/readelf
REALPATH?=		/bin/realpath
RLN?=			${INSTALL} -l rs
RM?=			/bin/rm -f
RMDIR?=			/bin/rmdir
SED?=			/usr/bin/sed
SETENV?=		/usr/bin/env
SH?=			/bin/sh
SORT?=			/usr/bin/sort
STRIP_CMD?=		/usr/bin/strip
STAT?=			/usr/bin/stat
# Command to run commands as privileged user
# Example: "/usr/local/bin/sudo -E sh -c" to use "sudo" instead of "su"
SU_CMD?=		/usr/bin/su root -c
SYSCTL?=		/sbin/sysctl
TAIL?=			/usr/bin/tail
TEST?=			test	# Shell builtin
TOUCH?=			/usr/bin/touch
TOUCH_FLAGS?=		-f
TR?=			/usr/bin/tr
TRUE?=			true	# Shell builtin
UMOUNT?=		/sbin/umount
UNAME?=			/usr/bin/uname
UNMAKESELF_CMD?=	${LOCALBASE}/bin/unmakeself
UNZIP_CMD?=		${LOCALBASE}/bin/unzip
UNZIP_NATIVE_CMD?=	/usr/bin/unzip
WHICH?=			/usr/bin/which
XARGS?=			/usr/bin/xargs
XMKMF?=			${LOCALBASE}/bin/xmkmf
YACC?=			/usr/bin/yacc

XZ?=			-Mmax
XZCAT=			/usr/bin/xzcat ${XZ}
XZ_CMD?=		/usr/bin/xz ${XZ}

MD5?=			/sbin/md5
SHA256?=		/sbin/sha256
SOELIM?=		/usr/bin/soelim

TAR?=	/usr/bin/tar

# EXTRACT_SUFX is defined in .pre.mk section
EXTRACT_CMD?=	${TAR}
EXTRACT_BEFORE_ARGS?=	-xf

ECHO_CMD?=		echo	# Shell builtin

# Used to print all the '===>' style prompts - override this to turn them off.
ECHO_MSG?=		${ECHO_CMD}

# Macro for doing in-place file editing using regexps
REINPLACE_ARGS?=	-i.bak
REINPLACE_CMD?=	${SED} ${REINPLACE_ARGS}

MAKE_FLAGS?=	-f
MAKEFILE?=		Makefile
MAKE_CMD?=		${BSDMAKE}
MAKE_ENV+=		PREFIX=${PREFIX} \
			LOCALBASE=${LOCALBASE} \
			CC="${CC}" CFLAGS="${CFLAGS}" \
			CPP="${CPP}" CPPFLAGS="${CPPFLAGS}" \
			LDFLAGS="${LDFLAGS}" LIBS="${LIBS}" \
			CXX="${CXX}" CXXFLAGS="${CXXFLAGS}" \
			MANPREFIX="${MANPREFIX}"

# Add -fno-strict-aliasing to CFLAGS with optimization level -O2 or higher.
# gcc 4.x enable strict aliasing optimization with -O2 which is known to break
# a lot of ports.
.if !defined(WITHOUT_NO_STRICT_ALIASING)
.if ${CC} != "icc"
.if empty(CFLAGS:M-fno-strict-aliasing)
CFLAGS+=       -fno-strict-aliasing
.endif
.endif
.endif

BINMODE=		555
MANMODE=		444
STRIP=			-s
_SHAREMODE=		0644

# A few aliases for *-install targets
INSTALL_PROGRAM=	${INSTALL} ${COPY} ${STRIP} -m ${BINMODE}
INSTALL_KLD=		${INSTALL} ${COPY} -m ${BINMODE}
INSTALL_LIB=		${INSTALL} ${COPY} ${STRIP} -m ${_SHAREMODE}
INSTALL_SCRIPT=		${INSTALL} ${COPY} -m ${BINMODE}
INSTALL_DATA=		${INSTALL} ${COPY} -m ${_SHAREMODE}
INSTALL_MAN=		${INSTALL} ${COPY} -m ${MANMODE}

CONFIGURE_SCRIPT?=	configure
CONFIGURE_CMD?=		./${CONFIGURE_SCRIPT}
CONFIGURE_TARGET?=	${HOSTARCH}-jwfhbld-${OPSYS:tl}${OSREL}
CONFIGURE_TARGET:=	${CONFIGURE_TARGET:S/--build=//}
CONFIGURE_LOG?=		config.log

.endif

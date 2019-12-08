# Ensure .CURDIR contains an absolute path without a trailing slash.  
.CURDIR:=		$(.CURDIR:tA)

check_defined = \
    $(strip $(foreach 1,$1, \
        $(call __check_defined,$1,$(strip $(value 2)))))
__check_defined = \
    $(if $(value $1),, \
      $(error Undefined $1$(if $2, ($2))))

ifndef _COMMANDSMKINCLUDED

_COMMANDSMKINCLUDED=	yes

AWK?=			/usr/bin/awk
BASENAME?=		/usr/bin/basename
BRANDELF?=		/usr/bin/brandelf
BREW?=			/usr/local/bin/brew
BSDMAKE?=		/usr/local/bin/bmake
BZCAT?=			/usr/bin/bzcat
BZIP2_CMD?=		/usr/bin/bzip2
CARGO?=			/usr/local/bin/cargo
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
DIALOG4PORTS?=		$(LOCALBASE)/bin/dialog4ports
DIFF?=			/usr/bin/diff
DIRNAME?=		/usr/bin/dirname
DISKUTIL?= 		/usr/sbin/diskutil
EGREP?=			/usr/bin/egrep
EXPR?=			/bin/expr
FALSE?=			false	# Shell builtin
FETCH_BINARY?=		/usr/bin/fetch
FETCH_ARGS?=		-Fpr
FETCH_REGET?=		1
FETCH_CMD?=		$(FETCH_BINARY) $(FETCH_ARGS)
FILE?=			/usr/bin/file
FIND?=			/usr/bin/find
FLEX?=			/usr/bin/flex
FMT?=			/usr/bin/fmt
FMT_80?=		$(FMT) 75 79
GIT?=			/usr/bin/git
GMAKE?=			/usr/bin/make
GREP?=			/usr/bin/grep
GUNZIP_CMD?=		/usr/bin/gunzip -f
GZCAT?=			/usr/bin/gzcat
GZIP?=			-9
GZIP_CMD?=		/usr/bin/gzip -nf $(GZIP)
HDIUTIL?=		/usr/bin/hdiutil
HDIUTIL_MOUNT?=		$(HDIUTIL) mount -nobrowse
HEAD?=			/usr/bin/head
HOSTNAME_CMD?=		/bin/hostname
ID?=			/usr/bin/id
IDENT?=			/usr/bin/ident
INSTALL?=		/usr/bin/install
JOT?=			/usr/bin/jot
LDCONFIG?=		/sbin/ldconfig
LHA_CMD?=		$(LOCALBASE)/bin/lha
LN?=			/bin/ln
LS?=			/bin/ls
MAKE?=			/usr/bin/make
MKDIR?=			/bin/mkdir -p
MKTEMP?=		/usr/bin/mktemp
MOUNT?=			/sbin/mount
MOUNT_DEVFS?=		$(MOUNT) -t devfs devfs
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
RLN?=			$(INSTALL) -l rs
RM?=			/bin/rm -f
RMDIR?=			/bin/rmdir
RUBY?=			/usr/bin/ruby
SED?=			/usr/bin/sed
SETENV?=		/usr/bin/env
SH?=			/bin/sh
SORT?=			/usr/bin/sort
STRIP_CMD?=		/usr/bin/strip
STAT?=			/usr/bin/stat
# Command to run commands as privileged user
# Example: "/usr/local/bin/sudo -E sh -c" to use "sudo" instead of "su"
SU_CMD?=		/usr/bin/sudo /usr/bin/su - root -c
SYSCTL?=		/sbin/sysctl
TAIL?=			/usr/bin/tail
TEST?=			test	# Shell builtin
TOUCH?=			/usr/bin/touch
TOUCH_FLAGS?=		-f
TR?=			/usr/bin/tr
TRUE?=			true	# Shell builtin
UMOUNT?=		/sbin/umount
UNAME?=			/usr/bin/uname
UNMAKESELF_CMD?=	$(LOCALBASE)/bin/unmakeself
UNZIP_CMD?=		$(LOCALBASE)/bin/unzip
UNZIP_NATIVE_CMD?=	/usr/bin/unzip
WHICH?=			/usr/bin/which
XARGS?=			/usr/bin/xargs
XMKMF?=			$(LOCALBASE)/bin/xmkmf
YACC?=			/usr/bin/yacc

XZ?=			-Mmax
XZCAT=			/usr/bin/xzcat $(XZ)
XZ_CMD?=		/usr/bin/xz $(XZ)

MD5?=			/sbin/md5
SHA256?=		/sbin/sha256
SOELIM?=		/usr/bin/soelim

TAR?=	/usr/bin/tar

ECHO_CMD?=		echo	# Shell builtin

# Used to print all the '===>' style prompts - override this to turn them off.
ECHO_MSG?=		$(ECHO_CMD)

# Macro for doing in-place file editing using regexps
REINPLACE_ARGS?=	-i.bak
REINPLACE_CMD?=	$(SED) $(REINPLACE_ARGS)

MAKE_FLAGS?=	-f
MAKEFILE?=		Makefile
MAKE_CMD?=		$(MAKE)
MAKE_ENV+=		PREFIX=$(PREFIX) \
			LOCALBASE=$(LOCALBASE) \
			CC="$(CC)" CFLAGS="$(CFLAGS)" \
			CPP="$(CPP)" CPPFLAGS="$(CPPFLAGS)" \
			LDFLAGS="$(LDFLAGS)" LIBS="$(LIBS)" \
			CXX="$(CXX)" CXXFLAGS="$(CXXFLAGS)" \
			MANPREFIX="$(MANPREFIX)"

# Add -fno-strict-aliasing to CFLAGS with optimization level -O2 or higher.
# gcc 4.x enable strict aliasing optimization with -O2 which is known to break
# a lot of ports.
ifndef WITHOUT_NO_STRICT_ALIASING
ifeq ($(CC),"icc")
ifeq ($(findstring -fno-strict-aliasing,$(CFLAGS)),"")
CFLAGS+=       -fno-strict-aliasing
endif
endif
endif

BINMODE=		555
MANMODE=		444
STRIP=			-s
_SHAREMODE=		0644

INSTALL_PROGRAM=	$(INSTALL) $(COPY) $(STRIP) -m $(BINMODE)
INSTALL_KLD=		$(INSTALL) $(COPY) -m $(BINMODE)
INSTALL_LIB=		$(INSTALL) $(COPY) $(STRIP) -m $(_SHAREMODE)
INSTALL_SCRIPT=		$(INSTALL) $(COPY) -m $(BINMODE)
INSTALL_DATA=		$(INSTALL) $(COPY) -m $(_SHAREMODE)
INSTALL_MAN=		$(INSTALL) $(COPY) -m $(MANMODE)

LINK_SCRIPT=		$(LN) -sf

CONFIGURE_SCRIPT?=	configure
CONFIGURE_CMD?=		./$(CONFIGURE_SCRIPT)
CONFIGURE_TARGET?=	$(HOSTARCH)-jwfhbld-$(OPSYS:tl)$(OSREL)
CONFIGURE_TARGET:=	$(CONFIGURE_TARGET:S/--build=//)
CONFIGURE_LOG?=		config.log

endif

ARCH:=		$(shell $(UNAME) -p)
OPSYS:=		$(shell $(UNAME) -s)
FQDN:=		$(shell $(HOSTNAME_CMD))

LOCALBASE?=	/usr/local
PREFIX?=	$(LOCALBASE)
MANPREFIX?=	$(LOCALBASE)
LOCALDEPS?=	# User configurable
LOCALBUILDS:=	$(shell $(FIND) "$(PWD)" -type d -maxdepth 1 \
		| $(XARGS) -n1 $(BASENAME) \
		| $(SORT) \
		| $(SED) -e 's/^/local-/')

MANDIRS+=	$(MANPREFIX)/man
INFO_PATH?=	share/info

UID:=		$(shell $(ID) -u)
GID:=		$(shell $(ID) -g)

WRKSRC=		$(PWD)

CONFIGURABLE=		0
ALL_TARGET?=		warn
INSTALL_TARGET?=	install

.DEFAULT_GOAL:=		$(ALL_TARGET)

SUBPROJECTS:=	$(patsubst ./%,%,$(shell $(FIND) . -mindepth 1 \( ! \( -regex '.*\.venv.*' -o -regex '.*\.pytest_cache.*' -o -regex '.*\.git/.*' \) \) -type d -exec [ -f {}/Makefile ] \; -print -prune 2>/dev/null))


AUTODOC_OFFSET:=	30

autodoc-default: Makefile
	@awk '\
	BEGIN { \
		title="$(CURDIR) Available Targets"; \
		print title; \
		while (c++ < length(title)) \
			printf "‾"; print ""; \
	} \
	/^##/ {\
		if ((getline targetname) > 0) { \
			if (/^[[:space:]]*$$/ !~ targetname) \
				++targets; \
			sub(/:.*$$/, "", targetname); \
			sub(/^## ?/, ""); \
			sub(/##.*$$/,""); \
			printf "%-$(AUTODOC_OFFSET)s%s\n", targetname, $$0; \
		}\
	} \
	END { \
		print "\nParsed "targets" auto-doc targets"; \
	}' $<

autodoc-quiet-default: Makefile
	@awk '\
	/^##/ {\
		if ((getline targetname) > 0) { \
			sub(/:.*$$/, "", targetname); \
			sub(/^## ?/, ""); \
			sub(/##.*$$/,""); \
			printf "%-$(AUTODOC_OFFSET)s%s\n", targetname, $$0; \
		}\
	}' $<

simple-doc:
	$(call check_defined $(SIMPLE_DOC_ITEMS), Need to define SIMPLE_DOC_ITEMS)
	$(call check_defined $(SIMPLE_DOC_INSTALL_STR), Need to define SIMPLE_DOC_INSTALL_STR)
	$(call check_defined $(SIMPLE_DOC_UNINSTALL_STR), Need to define SIMPLE_DOC_UNINSTALL_STR)
	$(call check_defined $(SIMPLE_DOC_ITERATOR), Need to define SIMPLE_DOC_ITERATOR)
	@for $(SIMPLE_DOC_ITERATOR) in $(SIMPLE_DOC_ITEMS); do \
		$(PRINTF) "%-$(AUTODOC_OFFSET)s$(SIMPLE_DOC_INSTALL_STR)\n" $$$(SIMPLE_DOC_ITERATOR)/install; \
		$(PRINTF) "%-$(AUTODOC_OFFSET)s$(SIMPLE_DOC_UNINSTALL_STR)\n" $$$(SIMPLE_DOC_ITERATOR)/uninstall; \
	done

check-brew:
	if [ ! -f $(BREW) ]; then \
		$(RUBY) -e "$$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"; \
	fi

warn:
	@echo "Make a specific target. To list targets run \`make list\`."

LIST_DEFAULT_TARGET:=	autodoc-quiet
list-default: autodoc-quiet
	@for PROJECT in $(SUBPROJECTS); do \
		$(MAKE) -C $$PROJECT --no-print-directory $(LIST_DEFAULT_TARGET) | $(SED) -e "s#^#$$PROJECT/#"; \
	done

%: %-default
	@$(TRUE)

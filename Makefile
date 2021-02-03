DOTFILES_TARGET_PREFIX=	install.dotfile
DOTFILES= 		.eslintrc.yml .gitconfig .vim .vimrc .ssh/config
DOTFILES_DARWIN=	
DOTFILES_FREEBSD=	.Xmodmap .synergy.conf .xinitrc .config/conky/conkystatus

LOCAL_SCRIPTS=		fixwhite svnignore okta-aws
LOCAL_SCRIPTS_DARWIN=	ical
LOCAL_SCRIPTS_FREEBSD=	handbrake conkystatus

PACKAGES=		alacritty awscli bat binutils bmake cmake coreutils cscope fish gcc gnupg gsed jq lame tmux wget
PACKAGES_DARWIN=	handbrake macvim pinentry-mac
PACKAGES_FREEBSD=	curl git gmake vim

EXTERNALS+=	github.com/oh-my-fish/oh-my-fish:.local/share/omf
EXTERNALS+=	github.com/tpope/vim-commentary:.vim/bundle/commentary
EXTERNALS+=	github.com/mattn/emmet-vim:.vim/bundle/emmet-vim
EXTERNALS+=	github.com/morhetz/gruvbox:.vim/bundle/gruvbox
EXTERNALS+=	github.com/morhetz/gruvbox-contrib:.appearance/gruvbox-contrib
EXTERNALS+=	github.com/jwfh/memorial-latex:Library/texmf/tex/latex/memorial-latex

.if defined(VERAFIN) && !empty(VERAFIN_GITHUB)
EXTERNALS+=	${VERAFIN_GITHUB}/Jacob-House/VeraTeX:Library/texmf/tex/latex/VeraTeX
.endif

.if ${OS} != Darwin
# Swap texmf path for a less macOS-specific one.
.endif

PKG_UPGRADE_INSTALLED?=	yes

.for custom in ${:!ls ./src/Mk/custom/*.mk | xargs -n1 basename!}
.include "./src/Mk/custom/${custom}"
.endfor
.include "./src/Mk/config.targets.mk"

install: dotfiles-install local-scripts-install packages-install

dotfiles-install:

.for DOTFILE in ${DOTFILES} ${DOTFILES_${OS}}
dotfiles-install: install.dotfile.${DOTFILE:C/^\.//:C/\//_/g}

.if !target(install.dotfile.${DOTFILE:C/^\.//:C/\//_/g})
install.dotfile.${DOTFILE:C/^\.//:C/\//_/g}: ${DOTFILE}
	@if [ -d "${HOME}/${DOTFILE}" ]; then \
		echo WARNING: '~/${DOTFILE}' is a directory.; \
		echo ; \
	fi
	@if [ -e "${HOME}/${DOTFILE}" ] && [ "$$(${SHA_PROGRAM} "${.CURDIR}/${DOTFILE}" | awk '{ print $$1 }')" != "$$( { ${SHA_PROGRAM} "${HOME}/${DOTFILE}" || :; } | awk '{ print $$1 }')" ]; then \
		echo WARNING: Contents of '~/${DOTFILE}' differ from what is in version control.; \
		echo WARNING: Resolve this conflict and run \`${MAKE}\' again.; \
		echo ; \
	else \
		rm -f "${HOME}/${DOTFILE}"; \
		ln -s "${.CURDIR}/${DOTFILE}" "${HOME}/${DOTFILE}" || \
		{ \
		echo WARNING: Linking file '~/${DOTFILE}' failed with error $$?.; \
		echo WARNING: Check permission errors and try again.; \
		echo ; \
		}; \
	fi
.endif
.endfor

local-scripts-install:

.for SCRIPT in ${LOCAL_SCRIPTS} ${LOCAL_SCRIPTS_${OS:tu}}
local-scripts-install: install.script.${SCRIPT}

.if !target(install.script.${SCRIPT})
install.script.${SCRIPT}:
	@if [ -d "${.CURDIR}/src/${SCRIPT}" ] && [ -f "${.CURDIR}/src/${SCRIPT}/Makefile" ]; then \
		${MAKE} -C "${.CURDIR}/src/${SCRIPT}" install; \
	else \
		echo ; \
		${WARN} Directory '${.CURDIR}/src/${SCRIPT}' does not exist or no Makefile was found. >&2; \
		${WARN} Skipping ${SCRIPT} installation. >&2; \
		echo ; \
	fi
.endif
.endfor

packages-install:

.for PACKAGE in ${PACKAGES} ${PACKAGES_${OS:tu}}
packages-install: install.package.${PACKAGE}

install.package.${PACKAGE}:
.if ${OS} == 'Darwin'
	@if ! ${PKG} list ${PACKAGE} >/dev/null 2>&1; then \
		${PKG} install ${PACKAGE}; \
	elif [ -n '${PKG_UPGRADE_INSTALLED:tu:MYES}' ]; then \
		${PKG} upgrade ${PACKAGE}; \
	else \
		${INFO} 'Package ${PACKAGE} is installed and $${PKG_UPGRADE_INSTALLED} is disabled.'; \
	fi
.elif ${OS} == 'FreeBSD'
	@${ECHO} ${.TARGET} not implemented!
	exit ${ENOSYS}
.endif
.endfor

externals:
.for EXTERNAL in ${EXTERNALS} ${EXTERNALS_${OS:tu}}
	@if [ -d ${.CURDIR}/${EXTERNAL:C/^[^:]{1,}://}/.svn ]; then \
		svn up ${.CURDIR}/${EXTERNAL:C/^[^:]{1,}://}; \
	else \
		svn co https://${EXTERNAL:C/:[^:]{1,}$//}/trunk ${.CURDIR}/${EXTERNAL:C/^[^:]{1,}://}; \
	fi
.endfor

.include "./src/Mk/config.commands.mk"

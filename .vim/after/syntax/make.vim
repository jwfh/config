" Vim syntax file
" Language:	BSD Makefile
" Maintainer:	Zsolt Udvari <uzsolt@uzsolt.hu>
" URL:  https://svn.uzsolt.hu/homefiles/vimfiles/trunk/after/syntax/make.vim?view=markup
" URL:  https://svn.uzsolt.hu/mysets/homefiles/vimfiles/trunk/after/syntax/make.vim?view=markup
" $LastChangedDate: 2018-07-18 12:47:46 +0200 (Sze, 18 júl. 2018) $
" $Rev: 925 $
" This is a simple extension to make.vim
" Basic syntax highlighting for Makefile of FreeBSD's ports system.
" Usage: copy it to ~/.vim/after/syntax/make.vim

" some directives
syn match makePreCondit	"^\. *\(if\>\|ifeq\>\|else\>\|endif\>\|ifneq\>\|ifdef\>\|ifndef\>\)"
syn match makeInclude	"^\. *include"
syn match makeStatement	"^\. *\(for\|endfor\)"
syn match makeExport    "^\. *\(export\|unexport\)\>"
syn match makeOverride	"^\. *MAKEOVERRIDES"
syn match makeSpecial   "[+:!]=\|=\|:"

" make targets
" syn match makeSpecTarget	"^\.\(SUFFIXES\|PHONY\|DEFAULT\|PRECIOUS\|IGNORE\|MAIN\|SILENT\|EXPORT_ALL_VARIABLES\|KEEP_STATE\|LIBPATTERNS\|NOTPARALLEL\|DELETE_ON_ERROR\|INTERMEDIATE\|POSIX\|SECONDARY\)\>"
syn match makeImplicit		"^\.[A-Za-z0-9_./\t -]\+\s*:$"me=e-1 nextgroup=makeSource
syn match makeImplicit		"^\.[A-Za-z0-9_./\t -]\+\s*:[^=]"me=e-2 nextgroup=makeSource

syn region makeTarget   transparent matchgroup=makeTarget start="^[~A-Za-z0-9_/${}()%-][A-Za-z0-9_/\t ${}()%-]*:\{1,2}[^:=]"rs=e-1 end=";"re=e-1,me=e-1 end="[^\\]$" keepend contains=makeIdent,makeSpecTarget,makeNextLine,makeComment skipnl nextGroup=makeCommands
syn match makeTarget		"^[~A-Za-z0-9_/${}()%*@-][A-Za-z0-9_/\t ${}()%*@-]*::\=\s*$" contains=makeIdent,makeSpecTarget,makeComment skipnl nextgroup=makeCommands,makeCommandError

syn match makePortsIdent  "PORTNAME\|DISTVERSION\(PREFIX\|SUFFIX\)\|\(DIST\|PORT\)VERSION\|PORTEPOCH"
syn match makePortsIdent  "PKGNAME\(PREFIX\|SUFFIX\)"
syn match makePortsIdent  "CATEGORIES\|MASTER_SITES\|DISTNAME\|DISTFILES\|MAINTAINER"
syn match makePortsIdent  "COMMENT\|LICENSE_FILE\|LICENSE"
syn match makePortsIdent  "BUILD_DEPENDS\|LIB_DEPENDS\|RUN_DEPENDS"

syn match makePortsBool "\<yes\|no\>"

syn match makePortsUseIdent "\(LD\|C\(\|PP\)\)FLAGS"
syn match makePortsUseIdent "GNU_CONFIGURE\|CONFIGURE_ARGS\|CONFIGURE_ENV\|CONFIGURE_OUTSOURCE"
syn match makePortsUseIdent "USES\|USE_\(GNOME\|RC_SUBR\|XORG\)"
syn match makePortsUseIdent ".*_USE\|.*USE_OFF"
syn match makePortsUseIdent ".*_USES\|.*_LDFLAGS"
syn match makePortsUseIdent ".*_\(BUILD\|LIB\|RUN\)_DEPENDS"
syn match makePortsUseIdent ".*_CONFIGURE_\(ENABLE\|WITH\)"
syn match makePortsUseIdent ".*_CMAKE_\(ON\|OFF\)"
syn match makePortsUseIdent ".*_MESON_\(TRUE\|FALSE\|YES\|NO\|ON\|OFF\)"

syn region makePortsMacros start="\$(" skip="\\)\|\\\\" end=")" contains=makePortsMacros
syn region makePortsMacros start="\${" skip="\\}\|\\\\" end="}" contains=makePortsMacros
syn match makePortsMacros "INSTALL_PROGRAM"

syn match makePortsOptions "OPTIONS_\(\(GROUP\|MULTI\|RADIO\)_[A-Z0-9]*\|\(GROUP\|MULTI\|RADIO\|DEFINE\|DEFAULT\)\)"
syn match makePortsOptions ".*_DESC"

syn match makePortsError "BROKEN_.*\|FORBIDDEN_.*\|IGNORE_.*\|BROKEN\|FORBIDDEN\|IGNORE\|ONLY_FOR_ARCHS\|NOT_FOR_ARCHS"

" hi! def link makeTarget  SpecialKey

hi! def link makePortsIdent Label
hi! def link makePortsUseIdent Type
hi! def link makePortsMacros Macro
hi! def link makePortsOptions Underlined
hi! def link makePortsError Error
hi! def link makePortsBool Boolean

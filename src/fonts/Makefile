FONTDIR!=	(cd '${.PARSEDIR}/../../.local/share/fonts'; pwd)

build:

install:
	[ -e '${HOME}/.fonts' ] || ${LN} -s '${FONTDIR}' '${HOME}/.fonts'
	[ -e '${HOME}/.local/share/fonts' ] || (${MKDIR} '${HOME}/.local/share' && ${LN} -s '${FONTDIR}' '${HOME}/.local/share/fonts')

.include "../Mk/config.commands.mk"

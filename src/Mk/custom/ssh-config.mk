.if !target(install.dotfile.ssh_config)
.info Processing target definition install.dotfile.ssh_config from ${.PARSEFILE}
install.dotfile.ssh_config: .ssh/config
	[ -d '${HOME}/.ssh' ] || ${MKDIR} '${HOME}/.ssh'
	${CAT} '${.CURDIR}/.ssh/config' > '${HOME}/.ssh/config'
.if defined(VERAFIN) && !empty(VERAFIN_GITHUB)
	${CURL} -sSfL 'https://${VERAFIN_GITHUB}/gist/Jacob-House/6e357c9aba3ec886e5805cac3198634a' >> '${HOME}/.ssh/config'
.endif
.endif

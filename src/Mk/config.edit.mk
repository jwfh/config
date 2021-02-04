edit:

.for EDIT_FILE in ${EDITS}
.if !defined(EDSCRIPT_${:!basename ${EDIT_FILE}!}) || empty(EDSCRIPT_${:!basename ${EDIT_FILE}!})
.warning Undefined ed script for EDIT file ${EDIT_FILE}! Skipping file modifications.
.else
. if !target(edit.${EDIT_FILE})
edit: edit.${:!basename ${EDIT_FILE}!}


EDSCRIPT!=	\
	{ [ -f '${.CURDIR}/ed/${EDSCRIPT_${:!basename ${EDIT_FILE}!}}.ed' ] && ${ECHO} '${.CURDIR}/ed/${EDSCRIPT_${:!basename ${EDIT_FILE}!}}.ed'; } || \
	{ [ -f '${.CURDIR}/ed/${EDSCRIPT_${:!basename ${EDIT_FILE}!}}.ed.gpg' ] && ${ECHO} '${.CURDIR}/ed/${EDSCRIPT_${:!basename ${EDIT_FILE}!}}.ed.gpg'; } || \
	:

.if empty(EDSCRIPT)
.error Unable to find ed script 'ed/${EDSCRIPT_${:!basename ${EDIT_FILE}!}}.ed' or 'ed/${EDSCRIPT_${:!basename ${EDIT_FILE}!}}.ed.gpg' for '${EDIT_FILE}'!
.endif

edit.${:!basename ${EDIT_FILE}!}: ${EDIT_FILE}
	{ ${ECHO}; ${INFO} Attempting to ${"${EDSCRIPT:M*.gpg}" == "":?apply:decrypt and apply} ed script ${EDSCRIPT:C/^${REPO_ROOT:C/\//\\\//}\///} for file '${EDIT_FILE}'; ${ECHO}; }
.  if "${EDSCRIPT:M*.gpg}" == ""
	${CAT} '${EDSCRIPT}' | tee /dev/stderr | ${ED} '${EDIT_FILE}' || :
.  else
	${SH} ${DECRYPT} '${EDSCRIPT}' 2>/dev/null | tee /dev/stderr | ${ED} '${EDIT_FILE}' || :
.  endif
. endif
.endif
.endfor

.include "${.PARSEDIR}/config.commands.mk"

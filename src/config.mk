# Ensure .CURDIR contains an absolute path without a trailing slash.  
.CURDIR:=		${.CURDIR:tA}

.include "config.commands.mk"
.include "config.env.mk"

CONFIGURABLE=		0
ALL_TARGET?=		all
INSTALL_TARGET?=	install

.BEGIN:			pre-banner \
			check-uid
.MAIN: 			${ALL_TARGET}
.END:			post-banner

all: 			check-local-deps \
			make-configuration \
			do-build 
install: 		configuration \
			${LOCALDEPS} \
			do-install
deinstall: check do-deinstall

# Fetch
.if !target(do-fetch)
do-fetch:
.if !empty(DISTFILES)
	@${SETENV} \
			${_DO_FETCH_ENV} ${_MASTER_SITES_ENV} \
			dp_SITE_FLAVOR=MASTER \
			${SH} ${SCRIPTSDIR}/do-fetch.sh ${DISTFILES:C/.*/'&'/}
	.endif
.endif

# Extract

clean-wrkdir:
	@${RM} -r ${WRKDIR}

.if !target(do-extract)
do-extract: ${EXTRACT_WRKDIR}
	@for file in ${EXTRACT_ONLY}; do \
		if ! (cd ${EXTRACT_WRKDIR} && ${EXTRACT_CMD} ${EXTRACT_BEFORE_ARGS} ${_DISTDIR}/$$file ${EXTRACT_AFTER_ARGS});\
		then \
			exit 1; \
		fi; \
	done
	@if [ ${UID} = 0 ]; then \
		${CHMOD} -R ug-s ${WRKDIR}; \
		${CHOWN} -R 0:0 ${WRKDIR}; \
	fi
	.endif

# Configure

.if !target(do-configure)
do-configure:
	@if [ -f ${SCRIPTDIR}/configure ]; then \
		cd ${.CURDIR} && ${SETENV} ${SCRIPTS_ENV} ${SH} \
		  ${SCRIPTDIR}/configure; \
	fi
.if defined(GNU_CONFIGURE)
	@CONFIG_GUESS_DIRS=$$(${FIND} ${WRKDIR} -name config.guess -o -name config.sub \
		| ${XARGS} -n 1 ${DIRNAME}); \
	for _D in $${CONFIG_GUESS_DIRS}; do \
		${RM} $${_D}/config.guess; \
		${CP} ${TEMPLATES}/config.guess $${_D}/config.guess; \
		${CHMOD} a+rx $${_D}/config.guess; \
		${RM} $${_D}/config.sub; \
		${CP} ${TEMPLATES}/config.sub $${_D}/config.sub; \
		${CHMOD} a+rx $${_D}/config.sub; \
	done
.endif
.if defined(HAS_CONFIGURE)
	@${MKDIR} ${CONFIGURE_WRKSRC}
	@(cd ${CONFIGURE_WRKSRC} && \
	    ${SET_LATE_CONFIGURE_ARGS} \
		if ! ${SETENV} CC="${CC}" CPP="${CPP}" CXX="${CXX}" \
	    CFLAGS="${CFLAGS}" CPPFLAGS="${CPPFLAGS}" CXXFLAGS="${CXXFLAGS}" \
	    LDFLAGS="${LDFLAGS}" LIBS="${LIBS}" \
	    INSTALL="/usr/bin/install -c" \
	    INSTALL_DATA="${INSTALL_DATA}" \
	    INSTALL_LIB="${INSTALL_LIB}" \
	    INSTALL_PROGRAM="${INSTALL_PROGRAM}" \
	    INSTALL_SCRIPT="${INSTALL_SCRIPT}" \
	    ${CONFIGURE_ENV} ${CONFIGURE_CMD} ${CONFIGURE_ARGS}; then \
			 ${ECHO_MSG} "===>  Script \"${CONFIGURE_SCRIPT}\" failed unexpectedly."; \
			 (${ECHO_CMD} ${CONFIGURE_FAIL_MESSAGE}) | ${FMT_80} ; \
			 ${FALSE}; \
		fi)
.endif
.endif


# Build
# XXX: ${MAKE_ARGS:N${DESTDIRNAME}=*} would be easier but it is not valid with the old fmake
DO_MAKE_BUILD?=	${SETENV} ${MAKE_ENV} ${MAKE_CMD} ${MAKE_FLAGS} ${MAKEFILE} ${_MAKE_JOBS} ${MAKE_ARGS:C,^${DESTDIRNAME}=.*,,g}
.if !target(do-build)
do-build:
	@(cd ${BUILD_WRKSRC}; if ! ${DO_MAKE_BUILD} ${ALL_TARGET}; then \
		if [ -n "${BUILD_FAIL_MESSAGE}" ] ; then \
			${ECHO_MSG} "===> Compilation failed unexpectedly."; \
			(${ECHO_CMD} "${BUILD_FAIL_MESSAGE}") | ${FMT_80} ; \
			fi; \
		${FALSE}; \
		fi)
	.endif

# Install

.if !target(do-install) && !defined(NO_INSTALL)
do-install:
	@(cd ${INSTALL_WRKSRC} && ${SETENV} ${MAKE_ENV} ${FAKEROOT} ${MAKE_CMD} ${MAKE_FLAGS} ${MAKEFILE} ${MAKE_ARGS} ${INSTALL_TARGET})
.endif

check-uid:
.if defined(UID) && ${UID} != 0 && !defined(INSTALL_AS_USER)
	@${ECHO_MSG} "===>  Switching to root credentials for '${.TARGET}' target"
	@cd ${.CURDIR} && \
		${SU_CMD} "${MAKE_CMD} ${.TARGET}"
	@${ECHO_MSG} "===>  Returning to user credentials"
.endif

check-local-deps: 
.for dep in ${LOCALDEPS}
.	if empty(LOCALBUILDS:M${dep})
		@${ECHO_MSG} "===> No local build for ${dep}"
		@${FALSE}
.	endif
.endfor

make-configuration: ${CONFFILE}.base 
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


${LOCALBUILDS}:
	@${ECHO} "===> Running local rule for ${.TARGET}"
	${MAKE} PREFIX=${PREFIX} -C ${.CURDIR:C/\/[^\/]*$//} ${.TARGET}



extract-message:
	@${ECHO_MSG} "===>  Extracting for ${PKGNAME}"
patch-message:
	@${ECHO_MSG} "===>  Patching for ${PKGNAME}"
configure-message:
	@${ECHO_MSG} "===>  Configuring for ${PKGNAME}"
build-message:
	@${ECHO_MSG} "===>  Building for ${PKGNAME}"
stage-message:
	@${ECHO_MSG} "===>  Staging for ${PKGNAME}"
install-message:
	@${ECHO_MSG} "===>  Installing for ${PKGNAME}"
test-message:
	@${ECHO_MSG} "===>  Testing for ${PKGNAME}"
package-message:
	@${ECHO_MSG} "===>  Building package for ${PKGNAME}"

# Empty pre-* and post-* targets

.if exists(${SCRIPTDIR})
.for stage in pre post
.for name in pkg check-sanity fetch extract patch configure build stage install package

.if !target(${stage}-${name}-script)
.if exists(${SCRIPTDIR}/${stage}-${name})
${stage}-${name}-script:
	@ cd ${.CURDIR} && ${SETENV} ${SCRIPTS_ENV} ${SH} \
			${SCRIPTDIR}/${.TARGET:S/-script$//}
.endif
.endif

.endfor
.endfor
.endif

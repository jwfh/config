PWD!=		pwd
OS!=		uname -s
PATCHDIR:=	${PWD}/freebsd-patch
WRKSRC:=	${PWD}/synergy-core
BUILD_WRKSRC:=	${PWD}/build

INSTALL_PROGRAM=install -s -m 555  
INSTALL_LIB=	install -s -m 0644
INSTALL_SCRIPT=	install -m 555
INSTALL_DATA=	install -m 0644
INSTALL_MAN=	install -m 444
PREFIX?=	/usr/local
MANPREFIX?=	/usr/local
PATH=		${WRKSRC}/.bin:${HOME}/.cargo/bin:${HOME}/bin:/usr/local/go/bin:${HOME}/config/bin:/usr/local/bin:/usr/bin:/sbin:/bin:/usr/sbin:/usr/local/sbin

PATCHFILES!=	find ${WRKSRC} -type f \( -name config.libpath -o  -name config.rpath -o -name configure -o -name libtool.m4 -o  -name ltconfig -o -name libtool -o -name aclocal.m4 -o  -name acinclude.m4 \)

install: ${OS}patch ${OS}build do-install

FreeBSDpatch: synergy-core/CMakeLists.txt
	sed -i.bak -e 's|return "/etc"|return "/usr/local/etc"|' ${WRKSRC}/src/lib/arch/unix/ArchFileUnix.cpp
	sed -i.bak -e 's|/etc/synergy.conf|/usr/local/etc/synergy.conf|' ${WRKSRC}/doc/synergys.man
	echo ${PATCHFILES}
.for f in ${PATCHFILES}
	sed -i.fbsd10bak  -e 's|freebsd1\*)|freebsd1.\*)|g' -e 's|freebsd\[12\]\*)|freebsd[12].*)|g' \
		-e 's|freebsd\[123\]\*)|freebsd[123].*)|g' -e 's|freebsd\[\[12\]\]\*)|freebsd[[12]].*)|g' \
		-e 's|freebsd\[\[123\]\]\*)|freebsd[[123]].*)|g'  ${f} 
	cmp -s ${f}.fbsd10bak ${f} || echo "===>   FreeBSD 10 autotools fix applied to ${f}"
	touch -f -mr ${f}.fbsd10bak ${f}
	rm -f ${f}.fbsd10bak
.endfor
	patch -f ${WRKSRC}/CMakeLists.txt ${PATCHDIR}/patch-CMakeLists.txt
	patch -f ${WRKSRC}/src/lib/net/SecureSocket.cpp ${PATCHDIR}/patch-src_lib_net_SecureSocket.cpp

FreeBSDbuild: synergy-core/CMakeLists.txt
	test -d ${BUILD_WRKSRC} || mkdir ${BUILD_WRKSRC}
	cd ${BUILD_WRKSRC} && env PATH=${PATH}	SHELL=/bin/sh CONFIG_SHELL=/bin/sh \
		cmake -DSYNERGY_REVISION:STRING=11020000 -DCMAKE_C_COMPILER:STRING="cc" \
		-DCMAKE_CXX_COMPILER:STRING="c++"  -DCMAKE_C_FLAGS:STRING="-O2 -pipe \
		-I/usr/local/include -L/usr/local/lib -fstack-protector-strong -fno-strict-aliasing " \
		-DCMAKE_CXX_FLAGS:STRING="-O2 -pipe -I/usr/local/include -fstack-protector-strong -fno-strict-aliasing" \
		-DCMAKE_EXE_LINKER_FLAGS:STRING=" -Wl,-rpath,/usr/local/lib -fstack-protector-strong -L/usr/local/lib " \
		-DCMAKE_INSTALL_PREFIX:PATH="/usr/local"  -DCMAKE_BUILD_TYPE:STRING="Release" \
		-DCMAKE_INSTALL_RPATH_USE_LINK_PATH=YES  -DSYNERGY_BUILD_LEGACY_INSTALLER:BOOL=OFF \
		-DSYNERGY_BUILD_LEGACY_GUI:BOOL=OFF -GNinja ${WRKSRC}
	cd ${BUILD_WRKSRC} &&  if ! env OPENSSLBASE=/usr/local OPENSSLDIR=/usr/local/openssl \
		OPENSSLINC=/usr/local/include OPENSSLLIB=/usr/local/lib OPENSSLRPATH=/usr/local/lib \
		PATH=${PATH} SHELL=/bin/sh CONFIG_SHELL=/bin/sh \
		NO_PIE=yes MK_DEBUG_FILES=no MK_KERNEL_SYMBOLS=no SHELL=/bin/sh NO_LINT=YES \
		DESTDIR=/usr/ports/sysutils/synergy-1/work/stage PREFIX=/usr/local  LOCALBASE=/usr/local\
		CC="cc" CFLAGS="-O2 -pipe  -I/usr/local/include -L/usr/local/lib -fstack-protector-strong \
		-fno-strict-aliasing "  CPP="cpp" CPPFLAGS=""  LDFLAGS=" -Wl,-rpath,/usr/local/lib \
		-fstack-protector-strong " LIBS=""  CXX="c++" CXXFLAGS="-O2 -pipe -I/usr/local/include \
		-L/usr/local/lib -fstack-protector-strong -fno-strict-aliasing  "  \
		ninja   -j`sysctl -n hw.ncpu` -v all; then  if [ -n "" ] ; \
		then  echo "===> Compilation failed unexpectedly.";  (echo "") | /usr/bin/fmt 75 79 ;  \
		fi;  false;  fi


do-install:
	${INSTALL_SCRIPT} ${PWD}/synergytoggle ${PREFIX}/bin/synergytoggle
.for f in synergyc synergyd synergys
	${INSTALL_PROGRAM} ${BUILD_WRKSRC}/bin/${f} ${PREFIX}/bin
.endfor
.for f in synergyc synergys
	${INSTALL_MAN} ${WRKSRC}/doc/${f}.man \
		${MANPREFIX}/man/man1/${f}.1
.endfor

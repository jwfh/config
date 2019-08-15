PREFIX?=	/usr/local	
INSTALL_PROGRAM=install -s -m 555  
INSTALL_LIB=	install -s -m 0644
INSTALL_SCRIPT=	install -m 555
INSTALL_DATA=	install -m 0644
INSTALL_MAN=	install -m 444
WRKSRC!=	pwd
DEST=		${PREFIX}/bin

install: ../../texmf .PHONY
	ln -sf ${WRKSRC}/../../texmf ${HOME}/texmf

uninstall:
	rm -f ${HOME}/texmf

.PHONY:

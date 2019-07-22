PKGS=		
PORTS=		compton compton-conf
OS!=		uname -s

install: .PHONY ${OS}-install
deinstall: .PHONY ${OS}-deinstall

FreeBSD-install: .PHONY ${PKGS:=-pkg} ${PORTS:=-port} 
FreeBSD-deinstall: .PHONY ${PKGS:=-rmpkg} ${PORTS:=-rmport} 

## We have no way using dependencies to determine whether a package/port has already 
## been installed. Hence all of the below targets require .PHONY as a dependency.
## pkg(1) and/or the Ports Makefiles have mechanisms to deal with an attempt to 
## install a package that has already been installed.

${PKGS:=-pkg}: .PHONY
	sudo pkg install -y ${@:-pkg=}

${PKGS:=-rmpkg}: .PHONY
	sudo pkg remove -y ${@:-pkg=}

${PORTS:=-port}: .PHONY
	port -i ${@:-port=}

${PORTS:=-rmport}: .PHONY
	port -d ${@:-rmport=}

.PHONY:

PORTS=		compton compton-conf
OS!=		uname -s

install: $(OS)-install
deinstall: $(OS)-deinstall

FreeBSD-install: $(PORTS:=-port)
FreeBSD-deinstall: $(PORTS:=-rmport)


$(PORTS:=-port): 
	@env PORTNAME=$(@:-port=) PORTPATH=$$(find /usr/ports -type d -name $(@:-port=) -mindepth 2 -maxdepth 2) $(MAKE) $@install
$(PORTS:=-portinstall): $(PORTPATH)/Makefile
	@printf "\n===> Switching to %s to build %s\n" "$(PORTPATH)" "$(PORTNAME)"
	sudo make -C "$(PORTPATH)" all install clean
$(PORTS:=-rmport): 
	@env PORTNAME=$(@:-rmport=) PORTPATH=$$(find /usr/ports -type d -name $(@:-rmport=) -mindepth 2 -maxdepth 2) $(MAKE) $(@:-rmport=-)portdeinstall
$(PORTS:=-portdeinstall): $(PORTPATH)/Makefile
	@printf "\n===> Switching to %s to deinstall %s\n" "$(PORTPATH)" "$(PORTNAME)"
	sudo make -C "$(PORTPATH)" deinstall clean


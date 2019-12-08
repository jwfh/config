include ../config.mk
DEST=	$(PREFIX)/bin
LINKS=	kitty
CAT:=	$(shell which cat)

## Symlink kitty to cat
install: $(LINKS:=-install)

## Remove kitty symlink
uninstall: $(LINKS:=-uninstall)

kitty-install: $(CAT)
	$(INSTALL_SCRIPT) -l sa $(CAT) $(DEST)/kitty

$(LINKS:=-uninstall):
	$(RM) $(DEST)/$(@:-uninstall=) 

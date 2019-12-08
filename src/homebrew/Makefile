include ../config.mk

## Install all Casks and formulae
install: $(SUBPROJECTS:=/install)

## Uninstall all Casks and formulae
uninstall: $(SUBPROJECTS:=/uninstall)

$(SUBPROJECTS:=/install):
	$(MAKE) -C $(@:/install=) install

$(SUBPROJECTS:=/uninstall):
	$(MAKE) -C $(@:/uninstall=) uninstall

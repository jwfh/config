include ../config.mk

## Install all Casks and formulae
install: $(SUBPROJECTS:=/install)

## Uninstall all Casks and formulae
uninstall: $(SUBPROJECTS:=/uninstall)

$(SUBPROJECTS:=/%):
	$(MAKE) -C $(shell echo $@ | sed -e 's#/# #') 

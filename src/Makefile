include config.mk

SUBPROJECTS= homebrew
LIST_DEFAULT_TARGET=	list

$(SUBPROJECTS)/%:
	$(MAKE) -C $(shell echo $@ | sed -e 's#/# #')  

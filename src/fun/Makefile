PREFIX?=	/usr/local
DEST=		$(PREFIX)/bin
CAT!=		which cat
RM!=		which rm

install:
	rm -f $(DEST)/kitty || ln -s $(CAT) $(DEST)/kitty
	rm -f $(DEST)/recycle || ln -s $(RM) $(DEST)/recycle
	rm -f $(DEST)/compost || ln -s $(RM) $(DEST)/compost

uninstall:
	rm -f $(DEST)/kitty 
	rm -f $(DEST)/recycle 
	rm -f $(DEST)/compost 


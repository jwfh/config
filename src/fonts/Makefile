WRKSRC!=	pwd
FONTDIR=	$(WRKSRC)/../..

install: ../../.local/share/fonts .PHONY
	test -d $(HOME)/.fonts || ln -sf $(FONTDIR)/.local/share/fonts $(HOME)/.fonts
	test -d $(HOME)/.local/share || mkdir -p $(HOME)/.local/share
	test -d $(HOME)/.local/share/fonts || ln -sf $(WRKSRC)/.local/share/fonts $(HOME)/.local/share/fonts

uninstall:
	rm -f $(HOME)/.fonts $(HOME)/.local/share/fonts

.PHONY:

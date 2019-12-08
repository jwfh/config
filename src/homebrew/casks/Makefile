include ../../config.mk

CASKS= \
	alacritty \
	atom \
	cd-to \
	cmake \
	iterm2 \
	mono-mdk \
	osxfuse \
	visual-studio \
	visual-studio-code \
	vlc \
	xquartz \
	xscreensaver

## Install all listed Homebrew Casks
install: $(CASKS:=/install) $(BOTTLES:=/install)

## Uninstall all listed Homebrew Casks
uninstall: $(BOTTLES:=/uninstall) $(CASKS:=/uninstall)

%/install: check-brew
	$(BREW) cask install $(@:/install=)

%/uninstall: check-brew
	$(BREW) cask uninstall $(@:/uninstall=)

autodoc-quiet: autodoc-quiet-default
	@$(MAKE) SIMPLE_DOC_ITEMS="$(CASKS)" SIMPLE_DOC_ITERATOR=CASK SIMPLE_DOC_INSTALL_STR="Install Homebrew Cask for \$$\$$CASK" SIMPLE_DOC_UNINSTALL_STR="Uninstall Homebrew Cask for \$$\$$CASK" simple-doc


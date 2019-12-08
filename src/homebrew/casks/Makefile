include ../../config.mk

CASKS= \
	adobe-creative-cloud \
	alacritty \
	atom \
	cd-to \
	cmake \
	docker \
	iterm2 \
	mactex \
	messenger \
	metasploit \
	mono-mdk \
	osxfuse \
	skype \
	visual-studio \
	visual-studio-code \
	vlc \
	wireshark \
	xquartz \
	xscreensaver

## Install all listed Homebrew Casks
install: $(CASKS:=/install) $(BOTTLES:=/install)

## Uninstall all listed Homebrew Casks
uninstall: $(BOTTLES:=/uninstall) $(CASKS:=/uninstall)

%/install: check-brew
	$(BREW) cask install $(@:/install=)

%/reinstall: check-brew
	$(BREW) cask reinstall $(@:/reinstall=)

%/uninstall: check-brew
	$(BREW) cask uninstall $(@:/uninstall=)

autodoc-quiet: autodoc-quiet-default
	@$(MAKE) SIMPLE_DOC_ITEMS="$(CASKS)" SIMPLE_DOC_ITERATOR=CASK SIMPLE_DOC_INSTALL_STR="Install Homebrew Cask for \$$\$$CASK" SIMPLE_DOC_UNINSTALL_STR="Uninstall Homebrew Cask for \$$\$$CASK" simple-doc


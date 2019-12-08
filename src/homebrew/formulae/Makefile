include ../../config.mk

BOTTLES= \
	arping \
	asciidoc \
	atlantis \
	cairo \
	certbot \
	clamav \
	curl-openssl \
	docker-compose \
	evince \
	ffmpeg \
	fish \
	gawk \
	gcc \
	gedit \
	git-cola \
	gnupg \
	gnuplot \
	google-authenticator-libpam \
	htop \
	imagemagick \
	ipython \
	jq \
	lastpass-cli \
	llvm \
	macvim \
	mplayer \
	neofetch \
	node \
	numpy \
	opencv \
	pdf-redact-tools \
	pypy \
	python \
	subnetcalc \
	tcpdump \
	terminator \
	termshark \
	uwsgi \
	wget 

## Install all listed Homebrew formulae
install: $(CASKS:=/install) $(BOTTLES:=/install)

## Uninstall all listed Homebrew formulae
uninstall: $(BOTTLES:=/uninstall) $(CASKS:=/uninstall)

%/install: check-brew
	$(BREW) install $(@:/install=)

%/uninstall: check-brew
	$(BREW) uninstall $(@:/uninstall=)

autodoc-quiet: autodoc-quiet-default
	@$(MAKE) SIMPLE_DOC_ITEMS="$(BOTTLES)" SIMPLE_DOC_ITERATOR=BOTTLE SIMPLE_DOC_INSTALL_STR="Install Homebrew formula for \$$\$$BOTTLE" SIMPLE_DOC_UNINSTALL_STR="Uninstall Homebrew formula for \$$\$$BOTTLE" simple-doc

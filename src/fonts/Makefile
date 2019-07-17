all: ../../.local/share/fonts .PHONY
	test -d $(HOME)/.fonts || ln -sf `pwd`/../../.local/share/fonts $(HOME)/.fonts
	test -d $(HOME)/.local/share || mkdir -p $(HOME)/.local/share
	test -d $(HOME)/.local/share/fonts || ln -sf `pwd`/../../.local/share/fonts $(HOME)/.local/share/fonts

clean:
	rm -f $(HOME)/.fonts $(HOME)/.local/share/fonts

.PHONY:

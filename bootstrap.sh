#!/usr/bin/env sh

set -e

export CC=/usr/bin/clang
export CXX=/usr/bin/clang++
export CPPFLAGS="-I/usr/local/openssl-1.0.2h/include"
export LDFLAGS="-L/usr/local/openssl-1.0.2h/lib"

# Close any open System Preferences panes, to prevent them from overriding
# settings we’re about to change
osascript -e 'tell application "System Preferences" to quit'

# Ask for the administrator password upfront
sudo -v

# Keep-alive: update existing `sudo` time stamp until `.macos` has finished
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

# Check if Xcode command line tools are installed.
# If not, the user needs to install it manually. Apple has made scripting this impossible.
gcc --version > /dev/null
if [ $? -ne 0 ]; then
	echo "Xcode Command Line tools not installed."
	echo ""
	echo "If Xcode installation does not begin automatically, you'll need to do"
	echo "this yourself."
	echo ""
	echo "Restart this script by running './bootstrap.sh' after installation "
	echo "is complete."
xcode-select --install &
exit 1
fi

# Install SDK Headers on Mojave
sudo installer -verbose -pkg /Library/Developer/CommandLineTools/Packages/macOS_SDK_headers_for_macOS_10.14.pkg -target /

# Install gfortran
TMPA=$(mktemp -d)
cd "$TMPA"
curl -OL "https://github.com/fxcoudert/gfortran-for-macOS/releases/download/8.2/gfortran-8.2-Mojave.dmg"
hdiutil mount -nobrowse gfortran-8.2-Mojave.dmg -mountpoint "/Volumes/gfortran-8.2-Mojave"
cd "/Volumes/gfortran-8.2-Mojave/gfortran-8.2-Mojave"
sudo installer -verbose -pkg gfortran.pkg -target /
cd "$HOME"
diskutil umount "/Volumes/gfortran-8.2-Mojave"
rm -rf "$TMPA"

# Install JDK
TMPA=$(mktemp -d)
cd "$TMPA"
curl -OL -H "Cookie: oraclelicense=accept-securebackup-cookie" "https://download.oracle.com/otn-pub/java/jdk/11.0.2+9/f51449fcd52f4d52b93a989c5c56ed3c/jdk-11.0.2_osx-x64_bin.dmg"
hdiutil mount -nobrowse jdk-11.0.2_osx-x64_bin.dmg -mountpoint /Volumes/jdk-11.0.2_osx-x64_bin
cd /Volumes/jdk-11.0.2_osx-x64_bin
sudo installer -verbose -pkg "JDK 11.0.2.pkg" -target /
cd "$HOME"
diskutil umount /Volumes/jdk-11.0.2_osx-x64_bin
rm -rf "$TMPA"

# Install cmake
TMPA=$(mktemp -d)
cd "$TMPA"
curl -OL "https://github.com/Kitware/CMake/releases/download/v3.13.3/cmake-3.13.3-Darwin-x86_64.dmg"
hdiutil mount -nobrowse cmake-3.13.3-Darwin-x86_64.dmg -mountpoint /Volumes/cmake-3.13.3-Darwin-x86_64
cp -rv /Volumes/cmake-3.13.3-Darwin-x86_64/CMake.app/ /Applications/CMake.app/
sudo /Applications/CMake.app/Contents/bin/cmake-gui --install
diskutil umount /Volumes/cmake-3.13.3-Darwin-x86_64
cd "$HOME"
rm -rf "$TMPA"

# Clone the dotfiles repository
git clone --recurse https://github.com/jwfh/dotfiles "$HOME/.dotfiles"
# There's more work to be done here to get Vim's YCM plugin working after we 
# install Python and rebuild LLVM and Clang

# Symlink our custom ZSH theme into the OMZ directory
ln -s "$HOME/.dotfiles/.oh-my-zsh-addons/xxf/themes/xxf.zsh-theme" "$HOME/.dotfiles/.oh-my-zsh/custom/themes/xxf.zsh-theme"
# Create other necessary symlinks
mkdir "$HOME/.config"
ln -sf "$HOME/.dotfiles/.config/fish" "$HOME/.config/fish"
ln -sf "$HOME/.dotfiles/.config/omf" "$HOME/.config/omf"
mkdir -p "$HOME/.local/share"
ln -sf "$HOME/.dotfiles/.local/share/fish" "$HOME/.local/share/fish"
ln -sf "$HOME/.dotfiles/.local/share/omf" "$HOME/.local/share/omf"
ln -sf "$HOME/.dotfiles/.vim" "$HOME/.vim"
ln -s "$HOME/.dotfiles/.vimrc" "$HOME/.vimrc"
ln -s "$HOME/.dotfiles/.zshrc" "$HOME/.zshrc"
ln -sf "$HOME/.dotfiles/.oh-my-zsh" "$HOME/.oh-my-zsh"
ln -sf "$HOME/.dotfiles/.texrc" "$HOME/.texrc"
ln -sf "$HOME/.dotfiles/.config/texstudio" "$HOME/.config/texstudio"
cp "$HOME/.dotfiles/.latexmkrc" "$HOME/.latexmkrc"

# Set ZSH to be the default shell. If you want Fish, add the path to 
# /etc/shells and run `chsh -s $(which fish)` from ZSH.
chsh -s $(which zsh)

# Install OpenSSL from source
TMPA=$(mktemp -d)
cd "$TMPA"
curl --remote-name https://www.openssl.org/source/openssl-1.0.2h.tar.gz
tar -xzvf openssl-1.0.2h.tar.gz
cd openssl-1.0.2h
./configure darwin64-x86_64-cc --prefix=/usr/local/openssl-1.0.2h shared
make depend
make
sudo make install
sudo ln -s /usr/local/openssl-1.0.2h/bin/openssl /usr/local/bin/openssl
openssl version -a
cd "$HOME"
rm -rf "$TMPA"

# Install LZMA
TMPA=$(mktemp -d)
cd "$TMPA"
curl -L "https://pilotfiber.dl.sourceforge.net/project/lzmautils/xz-5.2.4.tar.gz" -o "xz-5.2.4.tar.gz"
tar -xvf "xz-5.2.4.tar.gz"
cd xz-5.2.4
./configure
make
sudo make install
cd "$HOME"
rm -rf "$TMPA"

# Install Python
TMPA=$(mktemp -d)
cd "$TMPA"
curl -OL https://www.python.org/ftp/python/3.7.2/Python-3.7.2.tgz
tar -xvf Python-3.7.2.tgz
cd Python-3.7.2
./configure --prefix=/usr/local --enable-shared --enable-optimizations --with-openssl=/usr/local/openssl-1.0.2h/
make
sudo make install
cd "$HOME"
rm -rf "$TMPA"

# Install useful Python modules
sudo python3 -m pip install --upgrade pip
sudo python3 -m pip install numpy
sudo python3 -m pip install numba
sudo python3 -m pip install pyasn1
sudo python3 -m pip install pymysql
sudo python3 -m pip install cryptography
sudo python3 -m pip install dill
sudo python3 -m pip install Flask
sudo python3 -m pip install Flask-Login
sudo python3 -m pip install WTForms
sudo python3 -m pip install Flask-WTF
sudo python3 -m pip install itsdangerous
sudo python3 -m pip install Jinja2
sudo python3 -m pip install passlib
sudo python3 -m pip install Pillow
sudo python3 -m pip install pycups
sudo python3 -m pip install pysnmp
sudo python3 -m pip install requests
sudo python3 -m pip install urllib3
sudo python3 -m pip install Werkzeug
sudo python3 -m pip install flake8
sudo python3 -m pip install pylint
sudo python3 -m pip install pygments

# Install Mono
TMPA=$(mktemp -d)
cd "$TMPA"
curl -OL https://download.mono-project.com/archive/5.16.0/macos-10-universal/MonoFramework-MDK-5.16.0.220.macos10.xamarin.universal.pkg
sudo installer -verbose -pkg MonoFramework-MDK-5.16.0.220.macos10.xamarin.universal.pkg -target /
cd "$HOME"
rm -rf "$TMPA"

# Install Doxygen
TMPA=$(mktemp -d)
cd "$TMPA"
git clone https://github.com/doxygen/doxygen.git
cd doxygen
mkdir build
cd build
cmake -G "Unix Makefiles" ..
make
sudo make install
cd "$HOME"
rm -rf "$TMPA"

# Install Perl-compatible Regular Expressions
TMPA=$(mktemp -d)
cd "$TMPA"
curl -OL https://ftp.pcre.org/pub/pcre/pcre-8.42.tar.gz
tar -xvf pcre-8.42.tar.gz
cd pcre-8.42
./configure 
make
sudo make install
cd "$HOME"
rm -rf "$TMPA"

# Install Swig (dependency of LLDB below)
TMPA=$(mktemp -d)
cd "$TMPA"
curl -OL https://phoenixnap.dl.sourceforge.net/project/swig/swig/swig-3.0.12/swig-3.0.12.tar.gz
tar -xvf swig-3.0.12.tar.gz
cd swig-3.0.12
./configure
make
sudo make install
cd "$HOME"
rm -rf "$TMPA"

# Install LLVM/Clang from source to ensure we have the most up-to-date version
# (Building Vi's YCM plugin with anything but the latest here will make a big mess of Vi)
TMPA=$(mktemp -d)
git clone https://github.com/llvm/llvm-project.git "$TMPA"
cd "$TMPA"
mkdir build
cd build
cmake -DLLVM_ENABLE_PROJECTS="clang" -DCMAKE_BUILD_TYPE=Release -DLLVM_ENABLE_DOXYGEN=ON -G "Unix Makefiles" ../llvm
make -j$(sysctl -n hw.ncpu) VERBOSE=1
make check-all
sudo make install
cd "$HOME"
rm -rf "$TMPA"

# Install Lua
TMPA=$(mktemp -d)
cd "$TMPA"
curl -R -O http://www.lua.org/ftp/lua-5.3.5.tar.gz
tar zxf lua-5.3.5.tar.gz
cd lua-5.3.5
make macosx test
sudo make install
cd "$HOME"
rm -rf "$TMPA"

# Build MacVim 
TMPA=$(mktemp -d)
cd "$TMPA"
curl -OL https://github.com/macvim-dev/macvim/archive/snapshot-154.tar.gz
cd macvim-snapshot-154
make
make test
sudo make install
ln -s /Applications/MacVim.app/Contents/bin/vim /usr/local/bin/vim
ln -s /Applications/MacVim.app/Contents/bin/vim /usr/local/bin/vi
cd "$HOME"
rm -rf "$TMPA"

# Build Vi's YouCompleteMe plugin
cd "$HOME/.dotfiles/.vim/YouCompleteMe"
git submodule update --init --recursive 
python3 ./install.py --all 

# Install Rust ($HOME/.cargo/bin should be in path from config/fish/config.fish)
curl https://sh.rustup.rs -sSf | sh

# Install Go
TMPA=$(mktemp -d)
cd "$TMPA"
curl -OL https://dl.google.com/go/go1.11.4.darwin-amd64.pkg
sudo installer -verbose -pkg go1.11.4.darwin-amd64.pkg -target /
cd "$HOME"
rm -rf "$TMPA"

# Install Jekyll static site generator
sudo gem install jekyll

# Install Hugo static site generator
TMPA=$(mktemp -d)
cd "$TMPA"
curl -OL "https://github.com/gohugoio/hugo/releases/download/v0.53/hugo_0.53_macOS-64bit.tar.gz"
tar -xvf hugo_0.53_macOS-64bit.tar.gz
sudo mv hugo /usr/local/bin/
cd "$HOME"
rm -rf "$TMPA"

# Install wget
TMPA=$(mktemp -d)
cd "$TMPA"
curl -OL "https://ftp.gnu.org/gnu/wget/wget-1.20.tar.gz"
tar -xvf https://ftp.gnu.org/gnu/wget/wget-1.20.tar.gz
cd wget-1.20
sudo mkdir -p /usr/local/ssl
sudo ln -s /etc/ssl/cert.pem /usr/local/ssl/cert.pem
cd "$HOME"
rm -rf "$TMPA"

# Install Google Drive File Stream (for Google Apps)
TMPA=$(mktemp -d)
cd "$TMPA"
curl -OL "https://dl.google.com/drive-file-stream/GoogleDriveFileStream.dmg"
hdiutil mount -nobrowse GoogleDriveFileStream.dmg -mountpoint /Volumes/GoogleDriveFileStream
sudo installer -verbose -pkg /Volumes/GoogleDriveFileStream/GoogleDriveFileStream.pkg -target /
cd "$HOME"
rm -rf "$TMPA"

# Install Node.JS
TMPA=$(mktemp -d)
cd "$TMPA"
curl -OL "https://nodejs.org/dist/v10.15.0/node-v10.15.0.tar.gz"
tar -xvf node-v10.15.0.tar.gz
cd node-v10.15.0
./configure
make -j4
sudo make install
sudo ./tools/macos-firewall.sh
cd "$HOME"
rm -rf "$TMPA"

# Install LaTeX (MacTeX) and TeXstudio
TMPA=$(mktemp -d)
cd "$TMPA"
curl -OL "https://github.com/texstudio-org/texstudio/releases/download/2.12.14/texstudio-2.12.14-osx.dmg"
hdiutil mount -nobrowse texstudio-2.12.14-osx.dmg -mountpoint /Volumes/TeXstudio
cp -R /Volumes/TeXstudio/texstudio.app /Applications/TeXstudio.app/
diskutil umount /Volumes/TeXstudio 
# curl -OL "http://mirror.its.dal.ca/ctan/systems/mac/mactex/MacTeX.pkg"
curl -OL "http://www.cs.mun.ca/~jwhouse/mactex/MacTeX.pkg"
sudo installer -verbose -pkg MacTeX.pkg -target /
cd "$HOME"
rm -rf "$TMPA"

# Install HomeBrew - The missing package manager for macOS
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

# Install the things that Apple didn't
brew install graphviz
brew install wget
brew install trombonehero/homebrew-grading/libgrading

# Install htop
TMPA=$(mktemp -d)
cd "$TMPA"
curl -OL "https://hisham.hm/htop/releases/2.2.0/htop-2.2.0.tar.gz"
tar -xvf htop-2.2.0.tar.gz
cd htop-2.2.0
./configure
make
sudo make install
cd "$HOME"
rm -rf "$TMPA"

# Install cd to
TMPA=$(mktemp -d)
cd "$TMPA"
curl -OL https://github.com/jbtule/cdto/releases/download/2_6_0/cdto_2_6.zip
unzip cdto_2_6.zip
cd cdto_2_6
cp -R iterm/cd\ to.app/ "/Applications/cd to (iTerm).app/"
cp -R terminal/cd\ to.app/ "/Applications/cd to (Terminal).app/"
cd "$HOME"
rm -rf "$TMPA"

# Install Fish, the friendly interactive shell
TMPA=$(mktemp -d)
cd "$TMPA"
curl -OL "https://github.com/fish-shell/fish-shell/releases/download/3.0.0/fish-3.0.0.tar.gz"
tar -xvf fish-3.0.0.tar.gz
cd fish-3.0.0
./configure
make
sudo make install
cd "$HOME"
rm -rf "$TMPA"

# Install GitKraken
TMPA=$(mktemp -p)
cd "$TMPA"
curl -OL "https://release.gitkraken.com/darwin/installGitKraken.dmg"
hdiutil mount -nobrowse installGitKraken.dmg -mountpoint /Volumes/GitKraken
cp -R /Volumes/GitKraken/GitKraken.app /Applications
cd "$HOME"
diskutil umount /Volumes/GitKraken
rm -rf "$TMPA"

# Use MacApps to install a number of useful applications
curl -s 'https://macapps.link/en/firefox' | sh
curl -s 'https://macapps.link/en/chrome' | sh
curl -s 'https://macapps.link/en/intellij' | sh
curl -s 'https://macapps.link/en/docker' | sh
curl -s 'https://macapps.link/en/vscode' | sh
curl -s 'https://macapps.link/en/iterm' | sh
curl -s 'https://macapps.link/en/transmission' | sh
curl -s 'https://macapps.link/en/caffeine' | sh
curl -s 'https://macapps.link/en/diskmaker' | sh
curl -s 'https://macapps.link/en/spotify' | sh
curl -s 'https://macapps.link/en/vlc' | sh
curl -s 'https://macapps.link/en/handbrake' | sh
curl -s 'https://macapps.link/en/skype' | sh
curl -s 'https://macapps.link/en/slack' | sh

# Install Kinematic (Docker manager)
TMPA=$(mktemp -d)
cd "$TMPA"
curl -OL "https://download.docker.com/kitematic/Kitematic-Mac.zip"
unzip Kinematic-Mac.zip
cp -R ./Kitematic.app /Applications
cd "$HOME"
rm -rf "$TMPA"

# Change tracking speed
defaults write -g com.apple.trackpad.scaling -float 2.0

# Trackpad: enable tap to click for this user and for the login screen
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -int 1
defaults write NSGlobalDomain com.apple.mouse.tapBehavior -int 1

# Trackpad: map bottom right corner to right-click
# defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadCornerSecondaryClick -int 2
# defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadRightClick -bool true
# defaults -currentHost write NSGlobalDomain com.apple.trackpad.trackpadCornerClickBehavior -int 1
# defaults -currentHost write NSGlobalDomain com.apple.trackpad.enableSecondaryClick -bool true

# Always show scrollbars
defaults write NSGlobalDomain AppleShowScrollBars -string "Always"
# Possible values: `WhenScrolling`, `Automatic` and `Always`

# Automatically quit printer app once the print jobs complete
defaults write com.apple.print.PrintingPrefs "Quit When Finished" -bool true

# Disable the “Are you sure you want to open this application?” dialog
defaults write com.apple.LaunchServices LSQuarantine -bool false

# Disable Resume system-wide
defaults write com.apple.systempreferences NSQuitAlwaysKeepsWindows -bool false

# Reveal IP address, hostname, OS version, etc. when clicking the clock
# in the login window
sudo defaults write /Library/Preferences/com.apple.loginwindow AdminHostInfo HostName

# Disable automatic capitalization as it’s annoying when typing code
defaults write NSGlobalDomain NSAutomaticCapitalizationEnabled -bool false

# Disable automatic period substitution as it’s annoying when typing code
defaults write NSGlobalDomain NSAutomaticPeriodSubstitutionEnabled -bool false

# Require password immediately after sleep or screen saver begins
defaults write com.apple.screensaver askForPassword -int 1
defaults write com.apple.screensaver askForPasswordDelay -int 0

# Finder: allow quitting via ⌘ + Q; doing so will also hide desktop icons
defaults write com.apple.finder QuitMenuItem -bool true

# Show icons for hard drives, servers, and removable media on the desktop
defaults write com.apple.finder ShowExternalHardDrivesOnDesktop -bool true
defaults write com.apple.finder ShowHardDrivesOnDesktop -bool true
defaults write com.apple.finder ShowMountedServersOnDesktop -bool true
defaults write com.apple.finder ShowRemovableMediaOnDesktop -bool true

# Finder: show hidden files by default
defaults write com.apple.finder AppleShowAllFiles -bool true

# Finder: show all filename extensions
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

# Set Desktop as the default location for new Finder windows
# For other paths, use `PfLo` and `file:///full/path/here/`
# defaults write com.apple.finder NewWindowTarget -string "PfDe"
# defaults write com.apple.finder NewWindowTargetPath -string "file://${HOME}/Desktop/"
defaults write com.apple.finder NewWindowTarget -string "PfLo"
defaults write com.apple.finder NewWindowTargetPath -string "file://${HOME}/"

# Keep folders on top when sorting by name
defaults write com.apple.finder _FXSortFoldersFirst -bool true

# When performing a search, search the current folder by default
defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"

# Disable the warning when changing a file extension
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false

# Avoid creating .DS_Store files on network or USB volumes
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true

# Automatically open a new Finder window when a volume is mounted
defaults write com.apple.frameworks.diskimages auto-open-ro-root -bool true
defaults write com.apple.frameworks.diskimages auto-open-rw-root -bool true
defaults write com.apple.finder OpenWindowForNewRemovableDisk -bool true

# Enable snap-to-grid for icons on the desktop and in other icon views
/usr/libexec/PlistBuddy -c "Set :DesktopViewSettings:IconViewSettings:arrangeBy grid" ~/Library/Preferences/com.apple.finder.plist
/usr/libexec/PlistBuddy -c "Set :FK_StandardViewSettings:IconViewSettings:arrangeBy grid" ~/Library/Preferences/com.apple.finder.plist
/usr/libexec/PlistBuddy -c "Set :StandardViewSettings:IconViewSettings:arrangeBy grid" ~/Library/Preferences/com.apple.finder.plist

# Increase grid spacing for icons on the desktop and in other icon views
/usr/libexec/PlistBuddy -c "Set :DesktopViewSettings:IconViewSettings:gridSpacing 100" ~/Library/Preferences/com.apple.finder.plist
/usr/libexec/PlistBuddy -c "Set :FK_StandardViewSettings:IconViewSettings:gridSpacing 100" ~/Library/Preferences/com.apple.finder.plist
/usr/libexec/PlistBuddy -c "Set :StandardViewSettings:IconViewSettings:gridSpacing 100" ~/Library/Preferences/com.apple.finder.plist

# Increase the size of icons on the desktop and in other icon views
/usr/libexec/PlistBuddy -c "Set :DesktopViewSettings:IconViewSettings:iconSize 80" ~/Library/Preferences/com.apple.finder.plist
/usr/libexec/PlistBuddy -c "Set :FK_StandardViewSettings:IconViewSettings:iconSize 80" ~/Library/Preferences/com.apple.finder.plist
/usr/libexec/PlistBuddy -c "Set :StandardViewSettings:IconViewSettings:iconSize 80" ~/Library/Preferences/com.apple.finder.plist

# Use list view in all Finder windows by default
# Four-letter codes for the view modes: `icnv`, `clmv`, `Flwv`, `Nlsv`
defaults write com.apple.finder FXPreferredViewStyle -string "clmv"

# Enable AirDrop over Ethernet and on unsupported Macs running Lion
defaults write com.apple.NetworkBrowser BrowseAllInterfaces -bool true

# Show the ~/Library folder
chflags nohidden ~/Library

# Show the /Volumes folder
sudo chflags nohidden /Volumes

# Expand the following File Info panes:
# “General”, “Open with”, and “Sharing & Permissions”
defaults write com.apple.finder FXInfoPanesExpanded -dict \
	General -bool true \
	OpenWith -bool true \
	Privileges -bool true

# Show indicator lights for open applications in the Dock
defaults write com.apple.dock show-process-indicators -bool true

# Wipe all (default) app icons from the Dock
# This is only really useful when setting up a new Mac, or if you don’t use
# the Dock to launch apps.
defaults write com.apple.dock persistent-apps -array

# Make Dock icons of hidden applications translucent
defaults write com.apple.dock showhidden -bool true

# Don’t show recent applications in Dock
defaults write com.apple.dock show-recents -bool false

# Hot corners
# Possible values:
#  0: no-op
#  2: Mission Control
#  3: Show application windows
#  4: Desktop
#  5: Start screen saver
#  6: Disable screen saver
#  7: Dashboard
# 10: Put display to sleep
# 11: Launchpad
# 12: Notification Center
# Top left screen corner → Put display to sleep
defaults write com.apple.dock wvous-tl-corner -int 10
defaults write com.apple.dock wvous-tl-modifier -int 0
# Top right screen corner → Notification Center
defaults write com.apple.dock wvous-tr-corner -int 12
defaults write com.apple.dock wvous-tr-modifier -int 0
# Bottom left screen corner → Start screen saver
defaults write com.apple.dock wvous-bl-corner -int 5
defaults write com.apple.dock wvous-bl-modifier -int 0

# Prevent Safari from opening ‘safe’ files automatically after downloading
defaults write com.apple.Safari AutoOpenSafeDownloads -bool false

# Enable Safari’s debug menu
defaults write com.apple.Safari IncludeInternalDebugMenu -bool true

# Enable the Develop menu and the Web Inspector in Safari
defaults write com.apple.Safari IncludeDevelopMenu -bool true
defaults write com.apple.Safari WebKitDeveloperExtrasEnabledPreferenceKey -bool true
defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2DeveloperExtrasEnabled -bool true

# Enable continuous spellchecking
defaults write com.apple.Safari WebContinuousSpellCheckingEnabled -bool true
# Disable auto-correct
defaults write com.apple.Safari WebAutomaticSpellingCorrectionEnabled -bool false

# Warn about fraudulent websites
defaults write com.apple.Safari WarnAboutFraudulentWebsites -bool true

# Block pop-up windows
defaults write com.apple.Safari WebKitJavaScriptCanOpenWindowsAutomatically -bool false
defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2JavaScriptCanOpenWindowsAutomatically -bool false

# Disable auto-playing video
#defaults write com.apple.Safari WebKitMediaPlaybackAllowsInline -bool false
#defaults write com.apple.SafariTechnologyPreview WebKitMediaPlaybackAllowsInline -bool false
#defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2AllowsInlineMediaPlayback -bool false
#defaults write com.apple.SafariTechnologyPreview com.apple.Safari.ContentPageGroupIdentifier.WebKit2AllowsInlineMediaPlayback -bool false

# Add the keyboard shortcut ⌘ + Enter to send an email in Mail.app
defaults write com.apple.mail NSUserKeyEquivalents -dict-add "Send" "@\U21a9"

# Disable inline attachments (just show the icons)
defaults write com.apple.mail DisableInlineAttachmentViewing -bool true

# Disable Spotlight indexing for any volume that gets mounted and has not yet
# been indexed before.
# Use `sudo mdutil -i off "/Volumes/foo"` to stop indexing any volume.
sudo defaults write /.Spotlight-V100/VolumeConfiguration Exclusions -array "/Volumes"

# Change indexing order and disable some search results
# Yosemite-specific search results (remove them if you are using macOS 10.9 or older):
# 	MENU_DEFINITION
# 	MENU_CONVERSION
# 	MENU_EXPRESSION
# 	MENU_SPOTLIGHT_SUGGESTIONS (send search queries to Apple)
# 	MENU_WEBSEARCH             (send search queries to Apple)
# 	MENU_OTHER
defaults write com.apple.spotlight orderedItems -array \
	'{"enabled" = 1;"name" = "APPLICATIONS";}' \
	'{"enabled" = 1;"name" = "SYSTEM_PREFS";}' \
	'{"enabled" = 1;"name" = "DIRECTORIES";}' \
	'{"enabled" = 1;"name" = "PDF";}' \
	'{"enabled" = 1;"name" = "FONTS";}' \
	'{"enabled" = 0;"name" = "DOCUMENTS";}' \
	'{"enabled" = 0;"name" = "MESSAGES";}' \
	'{"enabled" = 0;"name" = "CONTACT";}' \
	'{"enabled" = 0;"name" = "EVENT_TODO";}' \
	'{"enabled" = 0;"name" = "IMAGES";}' \
	'{"enabled" = 0;"name" = "BOOKMARKS";}' \
	'{"enabled" = 0;"name" = "MUSIC";}' \
	'{"enabled" = 0;"name" = "MOVIES";}' \
	'{"enabled" = 0;"name" = "PRESENTATIONS";}' \
	'{"enabled" = 0;"name" = "SPREADSHEETS";}' \
	'{"enabled" = 0;"name" = "SOURCE";}' \
	'{"enabled" = 0;"name" = "MENU_DEFINITION";}' \
	'{"enabled" = 0;"name" = "MENU_OTHER";}' \
	'{"enabled" = 0;"name" = "MENU_CONVERSION";}' \
	'{"enabled" = 0;"name" = "MENU_EXPRESSION";}' \
	'{"enabled" = 0;"name" = "MENU_WEBSEARCH";}' \
	'{"enabled" = 0;"name" = "MENU_SPOTLIGHT_SUGGESTIONS";}'
# Load new settings before rebuilding the index
killall mds > /dev/null 2>&1
# Make sure indexing is enabled for the main volume
sudo mdutil -i on / > /dev/null
# Rebuild the index from scratch
sudo mdutil -E / > /dev/null

# Only use UTF-8 in Terminal.app
defaults write com.apple.terminal StringEncodings -array 4

# Use a modified version of the Solarized Dark theme by default in Terminal.app
osascript <<EOD
tell application "Terminal"
	local allOpenedWindows
	local initialOpenedWindows
	local windowID
	set themeName to "Solarized Dark xterm-256color"
	(* Store the IDs of all the open terminal windows. *)
	set initialOpenedWindows to id of every window
	(* Open the custom theme so that it gets added to the list
	   of available terminal themes (note: this will open two
	   additional terminal windows). *)
	do shell script "open '$HOME/.dotfiles/iTerm/" & themeName & ".terminal'"
	(* Wait a little bit to ensure that the custom theme is added. *)
	delay 1
	(* Set the custom theme as the default terminal theme. *)
	set default settings to settings set themeName
	(* Get the IDs of all the currently opened terminal windows. *)
	set allOpenedWindows to id of every window
	repeat with windowID in allOpenedWindows
		(* Close the additional windows that were opened in order
		   to add the custom theme to the list of terminal themes. *)
		if initialOpenedWindows does not contain windowID then
			close (every window whose id is windowID)
		(* Change the theme for the initial opened terminal windows
		   to remove the need to close them in order for the custom
		   theme to be applied. *)
		else
			set current settings of tabs of (every window whose id is windowID) to settings set themeName
		end if
	end repeat
end tell
EOD

# Enable “focus follows mouse” for Terminal.app and all X11 apps
# i.e. hover over a window and start typing in it without clicking first
defaults write com.apple.terminal FocusFollowsMouse -bool true
defaults write org.x.X11 wm_ffm -bool true

# Install the Solarized Dark theme for iTerm
open "${HOME}/.dotfiles/iTerm/Solarized Dark.itermcolors"

# Prevent Time Machine from prompting to use new hard drives as backup volume
defaults write com.apple.TimeMachine DoNotOfferNewDisksForBackup -bool true

# Disable local Time Machine backups
hash tmutil &> /dev/null && sudo tmutil disablelocal

# Show the main window when launching Activity Monitor
defaults write com.apple.ActivityMonitor OpenMainWindow -bool true

# Visualize CPU usage in the Activity Monitor Dock icon
defaults write com.apple.ActivityMonitor IconType -int 5

# Show all processes in Activity Monitor
defaults write com.apple.ActivityMonitor ShowCategory -int 0

# Sort Activity Monitor results by CPU usage
defaults write com.apple.ActivityMonitor SortColumn -string "CPUUsage"
defaults write com.apple.ActivityMonitor SortDirection -int 0

# Use plain text mode for new TextEdit documents
defaults write com.apple.TextEdit RichText -int 0
# Open and save files as UTF-8 in TextEdit
defaults write com.apple.TextEdit PlainTextEncoding -int 4
defaults write com.apple.TextEdit PlainTextEncodingForWrite -int 4

# Enable the debug menu in Disk Utility
defaults write com.apple.DiskUtility DUDebugMenuEnabled -bool true
defaults write com.apple.DiskUtility advanced-image-options -bool true

# Enable the automatic update check
defaults write com.apple.SoftwareUpdate AutomaticCheckEnabled -bool true

# Check for software updates daily, not just once per week
defaults write com.apple.SoftwareUpdate ScheduleFrequency -int 1

# Download newly available updates in background
defaults write com.apple.SoftwareUpdate AutomaticDownload -int 1

# Install System data files & security updates
defaults write com.apple.SoftwareUpdate CriticalUpdateInstall -int 1

# Turn on app auto-update
defaults write com.apple.commerce AutoUpdate -bool true

# Prevent Photos from opening automatically when devices are plugged in
defaults -currentHost write com.apple.ImageCapture disableHotPlug -bool true

# Expand the Chrome print dialog by default
defaults write com.google.Chrome PMPrintingExpandedStateForPrint2 -bool true
defaults write com.google.Chrome.canary PMPrintingExpandedStateForPrint2 -bool true

# Use `~/Documents/Torrents` to store incomplete downloads
defaults write org.m0k.transmission UseIncompleteDownloadFolder -bool true
defaults write org.m0k.transmission IncompleteDownloadFolder -string "${HOME}/Documents/Torrents"

# Use `~/Downloads` to store completed downloads
defaults write org.m0k.transmission DownloadLocationConstant -bool true

# Don’t prompt for confirmation before downloading
defaults write org.m0k.transmission DownloadAsk -bool false
defaults write org.m0k.transmission MagnetOpenAsk -bool false

# Don’t prompt for confirmation before removing non-downloading active transfers
defaults write org.m0k.transmission CheckRemoveDownloading -bool true

# Trash original torrent files
defaults write org.m0k.transmission DeleteOriginalTorrent -bool true

# Hide the donate message
defaults write org.m0k.transmission WarningDonate -bool false
# Hide the legal disclaimer
defaults write org.m0k.transmission WarningLegal -bool false

# IP block list.
# Source: https://giuliomac.wordpress.com/2014/02/19/best-blocklist-for-transmission/
defaults write org.m0k.transmission BlocklistNew -bool true
defaults write org.m0k.transmission BlocklistURL -string "http://john.bitsurge.net/public/biglist.p2p.gz"
defaults write org.m0k.transmission BlocklistAutoUpdate -bool true

# Randomize port on launch
defaults write org.m0k.transmission RandomPort -bool true

# Enable remote SSH
sudo systemsetup -f -setremotelogin on

for app in "Activity Monitor" \
	"Address Book" \
	"Calendar" \
	"cfprefsd" \
	"Contacts" \
	"Dock" \
	"Finder" \
	"Google Chrome Canary" \
	"Google Chrome" \
	"Mail" \
	"Messages" \
	"Opera" \
	"Photos" \
	"Safari" \
	"SizeUp" \
	"Spectacle" \
	"SystemUIServer" \
	"Terminal" \
	"Transmission" \
	"Tweetbot" \
	"Twitter" \
	"iCal"; do
	killall "${app}" &> /dev/null
done
echo "Done. Note that some of these changes require a logout/restart to take effect."



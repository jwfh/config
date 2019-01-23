#!/usr/bin/env sh

set -e

export CC=/usr/bin/clang
export CXX=/usr/bin/clang++
export CPPFLAGS="-I/usr/local/openssl-1.0.2h/include"
export LDFLAGS="-L/usr/local/openssl-1.0.2h/lib"

# Check if Xcode command line tools are installed.
# If not, the user needs to install it manually. Apple has made scripting this impossible.
xcode-select -p > /dev/null
if [ $? -ne 0 ]; then
echo << EndOfMessage
Xcode Command Line tools not installed.
If Xcode installation does not begin automatically, you'll need to do 
this yourself.\r\n\r\nRestart this script by running './bootstrap.sh'
after installation is complete.
EndOfMessage
xcode-select --install &
exit 1
fi

# Install gfortran
TMPA=$(mktemp -d)
cd "$TMPA"
curl -OL "https://github.com/fxcoudert/gfortran-for-macOS/releases/download/8.2/gfortran-8.2-Mojave.dmg"
hdiuril mount -nobrowse gfortran-8.2-Mojave.dmg -mountpoint "/Volumes/gfortran-8.2-Mojave"
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
sudo /Applications/CMake.app/Conents/bin/cmake-gui --install
diskutil umount /Volumes/cmake-3.13.3-Darwin-x86_64
cd "$HOME"
rm -rf "$TMPA"

# Clone the dotfiles repository
git clone --recurse https://github.com/jwfh/dotfiles "$HOME/.dotfiles"
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

# Add custom wallpaper
osascript -e "tell application \"Finder\" to set desktop picture to POSIX file \"$HOME/.dotfiles/images/coffee.jpg\""

# Install LZMA
TMPA=$(mktemp -d)
cd "$TMPA"
curl -L "https://pilotfiber.dl.sourceforge.net/project/lzmautils/xz-5.2.4.tar.gz" -o "xz-5.2.4.tar.gz"

# Install Python
TMPA=$(mktemp -d)
cd "$TMPA"
curl -OL https://www.python.org/ftp/python/3.7.2/Python-3.7.2.tgz
tar xzvf Python-3.7.2.tgz
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

# Install Rust ($HOME/.cargo/bin should be in path from config/fish/config.fish)
curl https://sh.rustup.rs -sSf | sh

# Install Go
TMPA=$(mktemp -d)
cd "$TMPA"
curl -OL https://dl.google.com/go/go1.11.4.darwin-amd64.pkg
sudo installer -verbose -pkg go1.11.4.darwin-amd64.pkg -target /
cd "$HOME"
rm -rf "$TMPA"

# Install gem
TMPA=$(mktemp -d)
git clone --recurse https://github.com/rubygems/rubygems "$TMPA"
cd "$TMPA"
sudo ruby setup.rb
cd "$HOME"
test -f "/System/Library/Frameworks/Ruby.framework/Versions/2.3/usr/bin/bundle" && sudo ln -s "/System/Library/Frameworks/Ruby.framework/Versions/2.3/usr/bin/bundle" "/usr/local/bin/bundle"
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

# Install HomeBrew - The missing package manager for macOS
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

# Install the things that Apple didn't
brew install wget
brew install npm
brew install dot
brew install doxygen
brew install htop
brew install golang
brew install trombonehero/homebrew-grading/libgrading

# Instal Fish, the friendly interactive shell
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

# Use MacApps to install a number of useful applications
curl -s 'https://macapps.link/en/firefox' | sh
curl -s 'https://macapps.link/en/chrome' | sh
curl -s 'https://macapps.link/en/drive' | sh
curl -s 'https://macapps.link/en/macvim' | sh
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

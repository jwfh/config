#!/usr/bin/env sh

export CC=/usr/bin/clang
export CXX=/usr/bin/clang++
export CPPFLAGS="-I/usr/local/opt/openssl/include"
export LDFLAGS="-L/usr/local/opt/openssl/lib"

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

# Install cmake
TMPA=$(mktemp -d)
cd "$TMPA"
curl -OL https://github.com/Kitware/CMake/releases/download/v3.13.3/cmake-3.13.3.tar.gz
tar -xzvf cmake-3.13.3.tar.gz
cd cmake-3.13.3
./bootstrap
make
make install
cd "$HOME"
rm -rf "$TMPA"

# Clone the dotfiles repository
git clone --recurse https://github.com/jwfh/dotfiles "$HOME/.dotfiles"

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

# Symlink our custom ZSH theme into the OMZ directory
ln -s "$HOME/.dotfiles/.oh-my-zsh-addons/xxf/themes/xxf.zsh-theme" "$HOME/.dotfiles/.oh-my-zsh/custom/themes/xxf.zsh-theme"

# Add custom wallpaper
sips -Z $(system_profiler SPDisplaysDataType | awk '/Resolution/{print $2}') $HOME/.dotfiles/images/coffee.png --out $HOME/.dotfiles/images/coffee-out.png
sips --cropToHeightWidth $(system_profiler SPDisplaysDataType | awk '/Resolution/{print $4, $2}') images/coffee-out.png
sips -Z $(system_profiler SPDisplaysDataType | awk '/Resolution/{print $2}') $HOME/.dotfiles/images/coffee-blur.png --out $HOME/.dotfiles/images/coffee-blur-out.png
sips --cropToHeightWidth $(system_profiler SPDisplaysDataType | awk '/Resolution/{print $4, $2}') images/coffee-blur-out.png
# Make the loginwindowbgconverter binary and then use it to generate the lock screen image 
sqlite3 ~/Library/Application\ Support/Dock/desktoppicture.db "update data set value = '$HOME/.dotfiles/images/coffee-out.png'";
killall Dock;

# Install Python
TMPA=$(mktemp -d)
cd "$TMPA"
curl -OL https://www.python.org/ftp/python/3.7.2/Python-3.7.2.tgz
tar xzvf Python-3.7.2.tgz
cd Python-3.7.2.tgz
./configure --prefix=/usr/local --enable-shared --enable-optimizations --with-openssl=/usr/local/openssl-1.0.2h/
make
make install
cd "$HOME"
rm -rf "$TMPA"

# Install useful Python modules
python3 -m pip install numpy
python3 -m pip install numba
python3 -m pip install pyasn1
python3 -m pip install pymysql
python3 -m pip install cryptography
python3 -m pip install dill
python3 -m pip install Flask
python3 -m pip install Flask-Login
python3 -m pip install WTForms
python3 -m pip install Flask-WTF
python3 -m pip install itsdangerous
python3 -m pip install Jinja2
python3 -m pip install passlib
python3 -m pip install Pillow
python3 -m pip install pycups
python3 -m pip install pysnmp
python3 -m pip install requests
python3 -m pip install urllib3
python3 -m pip install Werkzeug

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
rm -rf "$TMPA"

# Install Jekyll static site generator
gem install jekyll

# Install HomeBrew - The missing package manager for macOS
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

# Install the things that Apple didn't
brew install wget
brew install npm
brew install fish
brew install dot
brew install doxygen
brew install htop
brew install golang
brew install trombonehero/homebrew-grading/libgrading

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

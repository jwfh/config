# Path to Oh My Fish install.
set -q XDG_DATA_HOME
  and set -gx OMF_PATH "$XDG_DATA_HOME/omf"
  or set -gx OMF_PATH "$HOME/.local/share/omf"

# Load Oh My Fish configuration.
source $OMF_PATH/init.fish

alias gvim='/Applications/MacVim.app/Contents/MacOS/MacVim'

set -g CC /usr/bin/clang
set -g CXX /usr/bin/clang++

set -gx PATH $HOME/.cargo/bin $HOME/bin /opt/tools/anaconda3/bin $HOME/.dotfiles/bin $PATH


set -gx PKG_CONFIG_PATH "/usr/local/opt/libffi/lib/pkgconfig" $PKG_CONFIG_PATH 

# For compilers to find zlib you may need to set:
set -gx LDFLAGS "-L/usr/local/opt/zlib/lib" $LDFLAGS
set -gx CPPFLAGS "-I/usr/local/opt/zlib/include" $CPPFLAGS

# For pkg-config to find zlib you may need to set:
set -gx PKG_CONFIG_PATH "/usr/local/opt/zlib/lib/pkgconfig" $PKG_CONFIG_PATH 

# For compilers to find icu4c you may need to set:
set -gx LDFLAGS "-L/usr/local/opt/icu4c/lib" $LDFLAGS
set -gx CPPFLAGS "-I/usr/local/opt/icu4c/include" $CPPFLAGS

# For pkg-config to find icu4c you may need to set:
set -gx PKG_CONFIG_PATH "/usr/local/opt/icu4c/lib/pkgconfig" $PKG_CONFIG_PATH

# For compilers to find sqlite you may need to set:
set -gx LDFLAGS "-L/usr/local/opt/sqlite/lib" $LDFLAGS
set -gx CPPFLAGS "-I/usr/local/opt/sqlite/include" $CPPFLAGS

# For pkg-config to find sqlite you may need to set:
set -gx PKG_CONFIG_PATH "/usr/local/opt/sqlite/lib/pkgconfig" $PKG_CONFIG_PATH

# Enable Vi key bindings
fish_vi_key_bindings

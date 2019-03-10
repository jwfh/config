# Path to Oh My Fish install.
set -q XDG_DATA_HOME
  and set -gx OMF_PATH "$XDG_DATA_HOME/omf"
  or set -gx OMF_PATH "$HOME/.local/share/omf"

# Load Oh My Fish configuration.
source $OMF_PATH/init.fish

alias gvim='/Applications/MacVim.app/Contents/MacOS/MacVim'

set -g CC /usr/bin/clang
set -g CXX /usr/bin/clang++

set -gx PATH $HOME/.cargo/bin $HOME/bin /opt/tools/anaconda3/bin $PATH

# Enable Vi key bindings
fish_vi_key_bindings

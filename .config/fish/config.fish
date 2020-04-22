# Path to Oh My Fish install.
set -q XDG_DATA_HOME
  and set -gx OMF_PATH "$XDG_DATA_HOME/omf"
  or set -gx OMF_PATH "$HOME/.local/share/omf"

# Load Oh My Fish configuration.
source $OMF_PATH/init.fish

set -g CC /usr/bin/clang
set -g CXX /usr/bin/clang++

for d in /usr/local/bin $HOME/.cargo/bin $HOME/.local/bin $HOME/bin $HOME/config/bin /usr/local/go/bin /opt/tools/anaconda3/bin /usr/local/lib/php/arcanist/bin
        if test -d "$d"
                set -gx PATH "$d" $PATH
        end
end

set -x LESSOPEN '| lesspipe %s'

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

# Maybe fix libstdc++
# Apparently clang[++] isn't looking in /usr/local/include
set -gx CPPFLAGS "-I/usr/include -I/usr/local/include" $CPPFLAGS
set -gx LDFLAGS "-L/usr/lib -L/usr/local/lib" $LDFLAGS

# Enable Vi key bindings
fish_vi_key_bindings

alias tc='tmux new'
alias ta='tmux attach -t'
alias gd='git diff'

function shortURI --description 'Uses go.jwfh.ca to shorten a URI'
	if test (count $argv) -eq 1
		set uri $argv[1]
		curl -d url="$uri" https://go.jwfh.ca/api/create
	else if test (count $argv) -eq 2
		set uri $argv[1]
		set short $argv[2]
		curl -d url="$uri" -d short="$short" https://go.jwfh.ca/api/create
	end 
end 

if test -z "$SSH_ENV"
    set -xg SSH_ENV $HOME/.ssh/environment
end

if not __ssh_agent_is_started
    __ssh_agent_start
end


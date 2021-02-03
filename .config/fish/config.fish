# Path to Oh My Fish install.
set -q XDG_DATA_HOME
  and set -gx OMF_PATH "$XDG_DATA_HOME/omf"
  or set -gx OMF_PATH "$HOME/.local/share/omf"

# Load Oh My Fish configuration.
source $OMF_PATH/init.fish

set -g CC /usr/bin/clang
set -g CXX /usr/bin/clang++

set -gx PATH /usr/local/bin $PATH
for dir in $HOME/.cargo/bin $HOME/bin $HOME/.local/bin /usr/local/go/bin $HOME/.poetry/bin /opt/tools/anaconda/bin /usr/local/lib/php/arcanist/bin /Library/PostgreSQL/9.6/bin
    if test -d $dir
        set -gx PATH $dir $PATH
    end
end    

if command -v lesspipe >/dev/null 2>&1
    set -x LESSOPEN '| lesspipe %s'
end

set -gx PKG_CONFIG_PATH "/usr/local/opt/libffi/lib/pkgconfig" $PKG_CONFIG_PATH 

# For compilers to find zlib you may need to set:
if test -d /usr/local/opt/zlib/lib
    set -gx LDFLAGS "-L/usr/local/opt/zlib/lib" $LDFLAGS
    set -gx CPPFLAGS "-I/usr/local/opt/zlib/include" $CPPFLAGS
end

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
		curl -sSf -d url="$uri" https://go.jwfh.ca/api/create | python3 -m json.tool
	else if test (count $argv) -eq 2
		set uri $argv[1]
		set short $argv[2]
		curl -sSf -d url="$uri" -d short="$short" https://go.jwfh.ca/api/create | python3 -m json.tool
	end 
end 

set -g fish_user_paths "/usr/local/opt/expat/bin" $fish_user_paths
set -gx LDFLAGS "-L/usr/local/opt/expat/lib" $LDFLAGS
set -gx CPPFLAGS "-I/usr/local/opt/expat/include" $CPPFLAGS
set -gx PKG_CONFIG_PATH "/usr/local/opt/expat/lib/pkgconfig" $PKG_CONFIG_PATH
set -g fish_user_paths "/usr/local/opt/util-linux/bin" $fish_user_paths
set -g fish_user_paths "/usr/local/opt/util-linux/sbin" $fish_user_paths
set -g fish_user_paths "/usr/local/opt/gnu-getopt/bin" $fish_user_paths

function suid --description 'Like su but takes a UID to assume; UID need not exist on system.'
    if test (count $argv) -lt 1
        printf "suid requires at least 1 argument"
    else
        echo sudo -u \#$argv[1] $argv[2..]
    end
end
set -g fish_user_paths "/usr/local/opt/qt/bin" $fish_user_paths
set -g fish_user_paths "/usr/local/opt/python@3.8/bin" $fish_user_paths

set -gx PATH /Library/Java/JavaVirtualMachines/jdk1.8.0_211.jdk/Contents/Home/bin $PATH
# set -gx PATH /Library/Java/JavaVirtualMachines/adoptopenjdk-8.jdk/Contents/Home/bin $PATH

if test -d ~/.local/lib/z.lua
	source (lua "$HOME/.local/lib/z.lua/z.lua/z.lua" --init fish once | psub)
end


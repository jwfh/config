# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
  export ZSH=/Users/jacobhouse/.oh-my-zsh

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
#ZSH_THEME="robbyrussell"
#ZSH_THEME="random"
ZSH_THEME="xxf"
# ZSH_THEME="ys"
#ZSH_THEME="nodeys"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"


alias jh00461='sshfs -o allow_other,defer_permissions jh00461@garfield.cs.mun.ca: ~/jh00461/'
alias jwhouse='sshfs -o allow_other,defer_permissions jwhouse@ganymede.pcglabs.mun.ca: ~/jwhouse/'
alias mnyc='sshfs -o allow_other,defer_permissions jacobh1@nyc1-01.jacobhouse.ca:/var/www ~/nyc'
alias jacobh='mkdir ~/jacobh;mount_smbfs //jacobh@able.jacobhouse.ca/jacobh ~/jacobh'

function pdfpextr()
{
    # this function uses 3 arguments:
    #     $1 is the first page of the range to extract
    #     $2 is the last page of the range to extract
    #     $3 is the input file
    #     output file will be named "inputfile_pXX-pYY.pdf"
    gs -sDEVICE=pdfwrite -dNOPAUSE -dBATCH -dSAFER \
       -dFirstPage=${1} \
       -dLastPage=${2} \
       -sOutputFile=${3%.pdf}_p${1}-p${2}.pdf \
       ${3}
}

alias mountprv='diskutil coreStorage unlockVolume CBB346A1-A66E-4C26-A001-36193EA29992;diskutil mount /dev/disk2'
alias start_sage=''/Applications/SageMath-8.0.app/Contents/Resources/sage/sage' --notebook=sagenb'
export MAGICK_HOME=/Users/jacobhouse/ImageMagick-7.0.7/
export PATH="$MAGICK_HOME/bin:$PATH"
export DYLD_LIBRARY_PATH="$MAGICK_HOME/lib/"
export PATH="/Library/Java/JavaVirtualMachines/jdk-11.0.1.jdk/Contents/Home/bin:$PATH:/usr/local/Cellar/inetutils/1.9.4_1/bin"
function pdfppextr()
{
    # this function uses 3 arguments:
    #     $1 is the first page of the range to extract
    #     $2 is the last page of the range to extract
    #     $3 is the input file
    #     output file will be named "inputfile_pXX-pYY.pdf"
    gs -sDEVICE=pdfwrite -dNOPAUSE -dBATCH -dSAFER -dAutoRotatePages=/None \
       -dFirstPage=${1} \
       -dLastPage=${2} \
       -sOutputFile=${3%.pdf}_p${1}-p${2}.pdf \
       ${3}
}

alias tolatex='cp ~/.latexmkrc.orig ~/.latexmkrc'
alias totex='cp ~/.texmkrc ~/.latexmkrc'
alias kitty='cat'
alias cols='sudo defaults write com.apple.finder AlwaysOpenInColumnView True'

export JAVA_HOME=/Library/Internet\ Plug-Ins/JavaAppletPlugin.plugin/Contents/Home

alias flushdns='sudo killall -HUP mDNSResponder'
alias wifi1='sudo ifconfig en1 ether d4:33:a3:ed:f2:12;sudo networksetup -setairportpower en1 off;sudo networksetup -detectnewhardware;sudo hostname -s Janes-MacBook-Air.local;sudo networksetup -setairportpower en1 on'
alias wifi2='sudo ifconfig en1 ether 68:a8:6d:29:5c:b0;sudo networksetup -setairportpower en1 off;sudo networksetup -detectnewhardware;sudo hostname -s mbp.jwfh.ca;sudo networksetup -setairportpower en1 on'
alias wifi3='sudo ifconfig en1 ether 00:e2:e3:e4:e5:e6;sudo networksetup -setairportpower en1 off;sudo networksetup -detectnewhardware;sudo hostname -s MacBook-Pro.local;sudo networksetup -setairportpower en1 on'
alias wifi4='sudo ifconfig en1 ether 00:12:cb:c6:24:e2;sudo networksetup -setairportpower en1 off;sudo networksetup -detectnewhardware;sudo hostname -s M2007MB.local;sudo networksetup -setairportpower en1 on'
alias googledns='sudo networksetup -setdnsservers Wi-Fi 8.8.8.8 8.8.4.4;sudo killall -HUP mDNSResponder'
alias opendns='sudo networksetup -setdnsservers Wi-Fi 208.67.222.222 208.67.220.220 208.67.222.220 208.67.220.222;sudo killall -HUP mDNSResponder'
alias nortondns1='sudo networksetup -setdnsservers Wi-Fi 199.85.126.10 199.85.127.10;sudo killall -HUP mDNSResponder'
alias nortondns2='sudo networksetup -setdnsservers Wi-Fi 199.85.126.20 199.85.127.20;sudo killall -HUP mDNSResponder'
alias nortondns3='sudo networksetup -setdnsservers Wi-Fi 199.85.126.30 199.85.127.30;sudo killall -HUP mDNSResponder'
alias lockwifi='sudo airport prefs RequireAdminIBSS=YES RequireAdminPowerToggle=YES RequireAdminNetworkChange=YES'

alias rm='echo "Use trash command or the full path, i.e., /bin/rm"'

function trash() {
	mv ${1} ~/.Trash/
}

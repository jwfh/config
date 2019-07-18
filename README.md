# User Config and Preferences

#### _Recursively cloning this repository is not encouraged due to its size._

Rather, you may wish to do a non-recursive clone and initialize individual submodules as you see fit. The full recursively enumerated repository weights in at nearly 1.5GiB. This is due to linking to a number of packages source code with the [`src`](./src) directory, as well as numerous open source fonts in the [`.local/share/fonts`](./.local/share/fonts) directory.

## Installation 

Installation is done using a collection of `Makefile`s in the `src/` directory. It is the user's responsibility to ensure that the requisite Git submodules have been initialized for each build. 

Of course, on my system I go against the general suggestion to not recursively clone the repo so everything definitely is intialized. You may choose this route as well but be sure to clean up temporary build files or the local repo may grow quite large. I've made an effort for the `Makefile`s under [`src`](./src) to clean up after themselves but inevitably some will not.

These `Makefile`s currently support only **macOS** and **FreeBSD**. 


To install, run one of the following from your shell.

```fish
> cd $HOME/config/src               # Assumes the repo is cloned to $HOME/config 
> make (uname -s)                   # If your shell is Fish
> make `uname -s`                   # If your shell is Bash or ZSH
```

This will install all the software that I use that is compatible with your operating system and will place necessary configuration files in your home directory, as well as system directories.

## Available Software

<div class="software-table">

| Software | Description | FreeBSD Install Type | macOS Install Type |
|:--|:-|:--|:--|
| [Alacritty](./src/alacritty) | GPU-accelerated terminal emulator | `pkg(1)` binary | |
| [Apache](./src/apache) | Web server | `pkg(1)` binary | (preinstalled) |
| [`arandr`](./src/arandr) | Another RandR GUI manager | `pkg(1)` binary | &mdash; |
| [Automake](./src/automake) | | `pkg(1)` binary | |
| [BIND](./src/named) | DNS server | `pkg(1)` binary | |
| [Caffeinate](./src/caffeinate) | Prevent your computer from sleeping | `pkg(1)` installer | (preinstalled) |
| [Clang[++]](./src/clang) | LLVM's C/C++ compiler | `pkg(1)` binary | Xcode |
| [CMake](./src/cmake) | Cross-platform buildsystem generator | `pkg(1)` binary | `.dmg` binary install |
| [Coffeescript](./src/coffeescript) | | `npm(1)` package | `npm(1)` package |
| [Conky](./src/conky) | A system monitor for X | `pkg(1)` binary | &mdash; | 
| [CUPS](./src/cups) | The Common UNIX Printing System | `pkg(1)` binary | (preinstalled) |
| [`dictpass`](./src/dictpass) | Random word password generator (prefer [`xkcdpass`](./src/xkcdpass)) | linked shell script | linked shell script |
| [DiskMakerX](./src/diskmaker) | Create macOS installation disks | &mdash; | MacApps installer |
| [`dmenu`](./src/dmenu) | X11 menu application designed for the dwm window manager | `pkg(1)` bianry | &mdash; |
| [Docker](./src/docker) | | &mdash; | MacApps installer |
| [Doxygen](./src/doxygen) | documentation system for various programming languages | `pkg(1)` binary | source build |
| [ESLint](./src/eslint) | | `npm(1)` package | `npm(1)` package |
| [`feh`](./src/feh) | Image viewer that utilizes Imlib2 | `pkg(1)` binary | |
| [`ffmpeg`](./src/ffmpeg) | | `pkg(1)` binary | |
| [Firefox](./src/firefox) | | `pkg(1)` binary | MacApps installer | 
| [`fish`](./src/fish) | The friendly interactive shell | `pkg(1)` binary | source build |
| [Fonts\*\*](./src/fonts) | A collection of open source typefaces | linked submodules | linked submodules |
| [FUSE](./src/fusefs) | Filesystem in User Space | `pkg(1)` binary | |
| [Gatsby](./src/gatsby) | React-based static site generator | `npm(1)` package | `npm(1)` package |
| [GCC](./src/gcc) | GNU C compiler | `pkg(1)` binary | Xcode |
| [GDB](./src/gdb) | GNU Debugger | `pkg(1)` binary | |
| [`gfortran`](./src/gfortran) | GNU Fortran compiler | (preinstalled) | `.pkg` installer |
| [GhostScript](./src/gs) | | | |
| [Git](./src/git) | | `pkg(1)` binary | Xcode |
| [GitKraken](./src/gitkraken) | GUI-based Git repository manager | &mdash; | `.dmg` binary |
| [Google Chrome](./src/chrome) | | `pkg(1)` binary | MacApps installer | 
| [Google Drive FS](./src/drivefs) | Google Drive File Stream (for G Suite enterprise and education) | &mdash; | `.pkg` installer |
| [GraphViz](./src/) | Rich set of graph drawing tools | | HomeBrew binary |
| [HandBrake](./src/handbrake) | Open source media encoder | source build | source build |
| [Homebrew](./src/brew) | The missing package manager for macOS | &mdash; | `curl`ed Ruby script |
| [`htop`](./src/htop) | Interactive process viewer | `pkg(1)` binary | source build |
| [Hugo](./src/hugo) | Go-based static site generator |  | prebuilt binary |
| [`i3`] | Minimalist tiling window manager | `pkg(1)` binary | &mdash; |
| [`i3bar`] | | `pkg(1)` binary | &mdash; |
| [`i3lock-color`](./src/i3lock-color) | Fork of `i3lock(1)` that supports much more customization| source build | &mdash; | 
| [`i3status`] | | `pkg(1)` binary | &mdash; |
| [IntelliJ IDEA](./src/intellij) | JetBrains' fully featured Java IDE | `pkg(1)` binary | MacApps installer |
| [iTerm2](./src/iterm) | | &mdash; | MacApps installer |
| [JDK](./src/jdk) | Java Development Kit | `pkg(1)` binary | `.pkg` installer |
| [Jekkyl](./src/jekkyl) | Ruby-based static site generator |  | `gem(1)` install |
| [Kitematic](./src/kitematic) | GUI application to manage Docker containers | &mdash; | prebuilt binary |
| [LaTeX](./src/latex) | TeXLive/MacTeX implementations of TeX | `pkg(1)` binary | `.pkg` installer |
| [`lesspipe`](./src/lesspipe) | Enables `less(1)` to view non-text files | linked shell script | linked shell script |
| [libgrading](./src/libgrading) | C/C++ assignment autograding library | `pkg(1)` install | HomeBrew install | 
| [`lock`\*](./src/lock) | Wrapper around `i3lock(1)` and `scrot(1)` to make a nice lock screen | linked shell script | linked shell script |
| [Lua](./src/lua) | Small, compilable scripting language providing easy access to C code | `pkg(1)` binary | source build |
| [LZMA](./src/lzma) | Compress or decompress `.xz`and `lzma`files | `pkg(1)` binary | source build |
| [memorial-latex](./texmf/tex/latex/memorial-latex) | Fork of [memorial-latex](https://github.com/trombonehero/memorial-latex) LaTeX classes and style files | linked submodule | linked submodule |
| [Mono](./src/mono) | ECMA-CLI native code generator (Just-in-Time and Ahead-of-Time) | `pkg(1)` binary | `.pkg` installer |
| [`neofetch`](./src/neofetch) | Displays basic system information | linked shell script | linked shell script |
| [Ninja](./src/ninja) | Ninja build tool | `pkg(1)` binary | source build |
| [Node](./src/node) | Server-side Javascript runtime | `pkg(1)` binary | source build |
| [NPM](./src/npm) | Node Package Manager | `pkg(1)` binary | |
| [`pdfmerge`\*](./src/pdfmerge) | Wrapper around `gs(1)` to combine PDF files | source build | source build |
| [PCRE](./src/pcre) | Perl-compatible regular expressions | source build | source build |
| [`pidof`](./src/pidof) | | `pkg(1)` binary | |
| [Polybar](./src/polybar) | | `pkg(1)` binary | &mdash; |
| [Ports Tree\*\*](./src/ports) | | `portsnap(1)` | &mdash; |
| [Python](./src/python3) | | `pkg(1)` binary | `conda` install |
| [`pkg-config`](./src/pkg-config) | System for configuring build dependency information | `pkg(1)` binary install | source build |
| [`rofi`](./src/rofi) | Window switcher, run dialog and [`dmenu`](./src/dmenu) replacement | `pkg(1)` bianry | &mdash; |
| [Rust](./src/rust) | Language with a focus on memory safety and concurrency | shell script binary installler | shell script binary installer |
| [Skype](./src/skype) | Online video chatting software | &mdash; | MacApps installer |
| [Slack](./src/slack) | Collaborative, extensible IM client | | MacApps installer |
| [Spotify](./src/spotify) | Online music service | &mdash; | MacApps installer |
| [Swig](./src/swig) | Generates wrappers for calling C/C++ code from other languages | `pkg(1)` binary install | source build |
| [Synergy](./src/synergy) | Allows mouse and keyboard sharing between computers | source build | source build |
| [`tmux`](./src/tmux) | Terminal multiplexer | `pkg(1)` binary | |
| [Transmission](./src/transmission) | | &mdash; | MacApps installer |
| [Typescript](./src/typescript) | | `npm(1)` package | `npm(1)` package |
| [Vim/GVim/MacVim](./src/vim) | Vi IMproved, a programmer's text editor | `pkg(1)` binary | source build |
| [Visual Studio Code](./src/code) | | &mdash; | MacApps installer |
| [VLC Media Player](./src/vlc) | | `pkg(1)` binary | MacApps installer |
| [`wget`](./src/wget) | "The non-interactive network downloader" | `pkg(1)` binary | source build |
| [`xkcdpass`](./src/xkcdpass) | Generate passwords as in XKCD [\#936](https://xkcd.com/936/) | linked Python module | linked Python module |
| [XFCE](./src/xfce) | | `pkg(1)` binary | | 
| [Xorg](./src/xorg) | X server | `pkg(1)` binary | |
| [XPDF](./src/xpdf) | | `pkg(1)` binary | HomeBrew install |
| [XScreensaver](./src/xscreensaver) | Extensible screen saver and screen locking framework | source build | [HomeBrew](https://brew.sh/) cask |
| [YouCompleteMe](./src/ycm) | Vim client/server autocompletion engine | source build | source build |

</div>

\*Custom script/binary, \*\*Not strictly speaking "software"


## Some Notes About Configuration

# Possibly Useful Documentation

## Window Manager and Colour Scheme

* [Gruvbox configuration](https://github.com/morhetz/gruvbox/wiki/Configuration#ggruvbox_contrast_dark)

## BSD Packet Filter (PF)

* [PF - User's Guide](https://www.openbsd.org/faq/pf/index.html) ([backup](doc/pf/guide/index.html))
* [Firewalling with OpenBSD's PF packet filter](https://home.nuug.no/~peter/pf/en/index.html) ([backup](doc/pf/peter/index.html))
* [A Beginner's Guide To Firewalling with pf](http://srobb.net/pf.html)
* [Building The Network You Need With PF, The OpenBSD Packet Filter](https://home.nuug.no/~peter/pf/newest/) ([backup](doc/pf/build-bsdcan/index.html))



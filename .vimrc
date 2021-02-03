execute pathogen#infect()
filetype plugin indent on
syntax on

set number relativenumber
nnoremap <silent> <C-n> :set relativenumber!<cr>

set background=dark
" colorscheme solarized
colorscheme gruvbox
set mouse=nicr

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

" set t_Co=256
" set nocompatible
" set modelines=0
" set tabstop=2
" set shiftwidth=2
" set softtabstop=2
" set expandtab
" set encoding=utf-8
" set scrolloff=3
" set autoindent
" set showmode
" set showcmd
" set hidden
" set wildmenu
" set wildmode=longest,list,full
set visualbell
" set cursorline
" set ttyfast
" set ruler
" set backspace=indent,eol,start
" set laststatus=2
" set relativenumber

set undofile
set undodir=~/.vim/undo " where to save undo histories
set undolevels=1000         " How many undos
set undoreload=10000        " number of lines to save for undo
set backupdir=~/.vim/backup/
set directory=~/.vim/backup/

" let mapleader = ","
" let g:ctrlp_map = "<c-p>"
" nnoremap / /\v
" vnoremap / /\v
" nnoremap <leader><leader> <c-^>
" vnoremap <leader>G :w !gist -p -t %:e \| pbcopy<cr>
" nnoremap <C-u> gUiw
" inoremap <C-u> <esc>gUiwea
" nnoremap <C-p> Vy<esc>p
" vnoremap <leader>S y:execute @@<cr>
" nnoremap <leader>S ^vg_y:execute @@<cr>
" nnoremap vv ^vg_
" nnoremap gn <esc>:tabnew<cr>

" cnoremap <c-a> <home>
" cnoremap <c-e> <end>

" set ignorecase
" set smartcase
" set gdefault
" set incsearch
" set showmatch
" set hlsearch
" nnoremap <leader><space> :noh<cr>
" nnoremap <tab> %
" vnoremap <tab> %

" set wrap
" set formatoptions=qrn1
" set colorcolumn=85
" set list
" set listchars=tab:▸\ ,eol:¬

" nnoremap <up> <nop>
" nnoremap <down> <nop>
" nnoremap <left> <nop>
" nnoremap <right> <nop>
" inoremap <up> <nop>
" inoremap <down> <nop>
" inoremap <left> <nop>
" inoremap <right> <nop>
" nnoremap j gj
" nnoremap k gk
" nnoremap ; :

" nnoremap <leader>ev <C-w><C-v><C-l>:e $MYVIMRC<cr>
" inoremap jk <ESC>
" inoremap kj <ESC>
" nnoremap <leader>w <C-w>v<C-w>l
" nnoremap n nzzzv
" nnoremap N Nzzzv
" nnoremap H ^
" nnoremap L g_
" inoremap " '

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

let g:syntastic_mode_map = {
    \ "mode": "active",
    \ "passive_filetypes": ["tex"] }
let g:syntastic_python_checkers=['poetry run pylint']

autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab

let g:syntastic_cpp_checkers = ['clang_check', 'gcc']
let g:syntastic_cpp_clang_check_args = ['-extra-arg=-std=c++17']
let g:syntastic_cpp_compiler = 'clang++'
let g:syntastic_cpp_compiler_options = ' -std=c++17 -stdlib=libc++'

" Remaps for easy copy and paste from clipboard in Gvim
nmap <C-V> "+gP
imap <C-V> <ESC><C-V>a 
vmap <C-C> "+y
map <C-n> :NERDTreeToggle<CR>

au BufNewFile,BufRead Jenkinsfile setf groovy

" Only do this part when compiled with support for autocommands.
if has("autocmd")
    " Use filetype detection and file-based automatic indenting.
    filetype plugin indent on

    " Use actual tab chars in Makefiles.
    autocmd FileType make set tabstop=8 shiftwidth=8 softtabstop=0 noexpandtab
endif

" For everything else, use a tab width of 4 space chars.
set tabstop=4       " The width of a TAB is set to 4.
                    " Still it is a \t. It is just that
                    " Vim will interpret it to be having
                    " a width of 4.
set shiftwidth=4    " Indents will have a width of 4.
set softtabstop=4   " Sets the number of columns for a TAB.
set expandtab       " Expand TABs to spaces.

map ,e :e <C-R>=expand("%:p:h") . "/" <CR>
map ,t :tabe <C-R>=expand("%:p:h") . "/" <CR>
map ,s :split <C-R>=expand("%:p:h") . "/" <CR>

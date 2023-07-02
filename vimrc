"       ,---.  ,--,           ,'  , `. 
"      /__./|,--.'|        ,-+-,.' _ | 
" ,---.;  ; ||  |,      ,-+-. ;   , || 
"/___/ \  | |`--'_     ,--.'|'   |  || 
"\   ;  \ ' |,' ,'|   |   |  ,', |  |, 
" \   \  \: |'  | |   |   | /  | |--'  
"  ;   \  ' .|  | :   |   : |  | ,     
"   \   \   ''  : |__ |   : |  |/      
"    \   `  ;|  | '.'||   | |`-'       
"     :   \ |;  :    ;|   ;/           
"      '---" |  ,   / '---'            
"             ---`-'                  
"Author: Sergio Rodríguez
set rnu
set bg=dark
filetype on
syntax on
filetype plugin indent on
set modelines=0
set wrap
set textwidth=79
set formatoptions=tcqrn1
set noshiftround
set scrolloff=5
set ttyfast
set laststatus=2
set showmode
set showcmd
set matchpairs+=<:>
set number
set statusline=%F%m%r%h%w\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [POS=%l,%v][%p%%]\ [BUFFER=%n]\ %{strftime('%c')}
set encoding=utf-8
set hlsearch
set incsearch
set ignorecase
set smartcase
set viminfo='100,<9999,s100

"Plugin autoinstalling
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')

"Syntax highlighting and autocompletion
Plug 'sheerun/vim-polyglot'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'jiangmiao/auto-pairs'
Plug 'fatih/vim-go'
Plug 'alvan/vim-closetag'
"File search and navigation
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'preservim/nerdtree'

"Editor interface and theming
Plug 'morhetz/gruvbox', { 'as': 'gruvbox' }
Plug 'itchyny/lightline.vim'
Plug 'yggdroot/indentline'
Plug 'puremourning/vimspector'

call plug#end()

let g:lightline = {'colorscheme': 'gruvbox'}
colorscheme gruvbox
" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
" Move 1 more lines up or down in normal and visual selection modes.
vnoremap J :m '>+1<CR>gv=gv
nnoremap K :m .-2<CR>==
nnoremap J :m .+1<CR>==
vnoremap K :m '<-2<CR>gv=gv

set termguicolors
set lazyredraw

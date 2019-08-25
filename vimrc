"-------------------------------------------------------------------
" VIM configure
" Writen by: Eric Ren
" Latest modified time：2014-11-24
"-------------------------------------------------------------------

"-------------------------------------------------------------------
"When editing a file, always jump to the last cursor position
"-------------------------------------------------------------------
if has("autocmd")
  autocmd BufReadPost * if line("'\"") > 0 && line ("'\"") <= line("$") | exe "normal! g'\"" | endif

  autocmd FileType python set expandtab
  autocmd FileType python set ts=4
  autocmd FileType python set sw=4

  autocmd FileType c set noexpandtab
  autocmd FileType c set ts=4
  autocmd FileType c set sw=4
else
  set tabstop=4 " 制表符为4
  set shiftwidth=4 "input settings
endif

"-------------------------------------------------------------------
"Fx mapping
"-------------------------------------------------------------------
"F1 reserved for gnome help
"F2
"F3, F4 for vim-autotags
"F5
"F6
"F7
nnoremap <silent> <F7> :CtrlPMRUFiles<CR>
"F8 for syntastic nnoremap <silent> <F8> :lclose<CR>
"F9 for colorcolumn
"F12 for tagbar

"-------------------------------------------------------------------
"Quik switch between splited windows
"-------------------------------------------------------------------
nmap <silent> <A-Up> :wincmd k<CR>
nmap <silent> <A-Down> :wincmd j<CR>
nmap <silent> <A-Left> :wincmd h<CR>
nmap <silent> <A-Right> :wincmd l<CR>

"-------------------------------------------------------------------
"What if you type wrong commands
"-------------------------------------------------------------------
cnoremap Q! q!
cnoremap Q1 q!
command Q q
command Wq wq
command WQ wq
command W w

"-------------------------------------------------------------------
"Remove trailing spaces
"-------------------------------------------------------------------
function! RemoveTrailingSpace()
  if $VIM_HATE_SPACE_ERRORS != '0'
     normal m`
     silent! :%s/\s\+$//e
     normal ``
  endif
endfunction
" autocmd BufWritePre * nested call RemoveTrailingSpace()
nnoremap <F6> :call RemoveTrailingSpace()

"-------------------------------------------------------------------
"un/fold code block by space
"-------------------------------------------------------------------
"set foldenable
"set foldmethod=manual
set foldmethod=indent
set foldnestmax=10
set nofoldenable
set foldlevel=2

nnoremap <space> @=((foldclosed(line('.')) < 0) ? 'zc':'zo')<CR>

"-------------------------------------------------------------------
"Text format
"-------------------------------------------------------------------
syntax on "使用语法高亮
set autoread "正在编辑文件被其他程序改动时自动重新加载
"set wrap "自动换行
"set textwidth=92
set linebreak "整词换行
set formatoptions=tcrqn "自动格式化
set autoindent "继承前一行的缩进方式，特别适用于多行注释
set smartindent "为C程序提供自动缩进
set cindent "使用C样式的缩进

"search settings
set hlsearch
set incsearch
set ignorecase
set smartcase

"-------------------------------------------------------------------
"Display settings section
"-------------------------------------------------------------------
set number
set ruler
set showmode
set wildmenu
set wildmode=longest:full,full
set cursorline "突出显示当前行
set showmatch " 显示括号匹配
set cursorline
"hi CursorColumn cterm=NONE ctermbg=darkred ctermfg=233 guibg=darkred guifg=white
"hi CursorLine cterm=NONE ctermbg=149 ctermfg=233 guibg=NONE guifg=NONE
set cul cuc

"turn on/off color-column display
nnoremap <silent> <F12> :if &colorcolumn <Bar>
                \   set colorcolumn= <Bar>
                \ else <Bar>
                \   set colorcolumn=80 <Bar>
                \ endif <CR>

"-------------------------------------------------------------------
"Misc
"-------------------------------------------------------------------
"backspace setting
set backspace=indent,eol,start

"support gnu syntaxt
let c_gnu = 1
"show error for mixed tab-space
let c_space_errors = 1
let c_no_tab_space_error = 1
"don't show gcc statement expression ({x, y;}) as error
let c_no_curly_error = 1

set nobackup
setlocal noswapfile
set bufhidden=hide

highlight clear SignColumn
highlight clear LineNr

set fenc=utf-8
set fencs=utf-8,usc-bom,euc-jp,gb18030,gbk,gb2312,cp936

"------------------------------------------------------------------
" setting for ctags and cscope
"------------------------------------------------------------------
set cscopetag  "pop a list when hitting positions

"-------------------------------------------------------------------
"Plugins
"-------------------------------------------------------------------
"Plugins Begin
set nocompatible              " be iMproved, required
filetype on
filetype plugin on            " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

Plugin 'ianva/vim-youdao-translater'

" go 主要插件
Plugin 'fatih/vim-go', { 'tag': '*' }
" go 中的代码追踪，输入 gd 就可以自动跳转
Plugin 'dgryski/vim-godef'

Plugin 'scrooloose/syntastic'
"bad than powerline for me
Plugin 'bling/vim-airline'
Plugin 'edsono/vim-matchit'
Plugin 'elzr/vim-json'
Plugin 'honza/vim-snippets'
Plugin 'justinmk/vim-sneak'
Plugin 'ludovicchabant/vim-lawrencium'
Plugin 'mhinz/vim-signify'
Plugin 'plasticboy/vim-markdown'
Plugin 'scrooloose/nerdcommenter'
Plugin 'sjl/gundo.vim'
"a Git wrapper
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-sleuth'
Plugin 'tpope/vim-surround'
Plugin 'tyru/open-browser.vim'
Plugin 'vim-scripts/a.vim'
Plugin 'tpope/vim-unimpaired'

"Color schemes
" colorscheme neodark
Plugin 'KeitaNakamura/neodark.vim'
" colorscheme monokai
Plugin 'crusoexia/vim-monokai'
" colorscheme github
Plugin 'acarapetis/vim-colors-github'
" colorscheme one
Plugin 'rakr/vim-one'

"Wrapper of ctags and cscope
"<F4>: rebuild and load tags and scopedb.
Plugin 'basilgor/vim-autotags'
"Project/Filetree Browsing
Plugin 'scrooloose/nerdtree'
"Code Browsing
Plugin 'majutsushi/tagbar'
"Fuzzy file, buffer, mru, tag, ... finder with regexp support.
"help 'ctrlp'
Plugin 'kien/ctrlp.vim'
"enhance statusline, same as airline
Plugin 'Lokaltog/vim-powerline'
"insert completion, it's better than supertab I think
Plugin 'Valloric/YouCompleteMe'
"spell checker
Plugin 'vim-scripts/spell.vim'
" autosess
Plugin 'powerman/vim-plugin-autosess'
" PaperColor
Plugin 'NLKNguyen/papercolor-theme'

""have not try yet
Plugin 'tagexplorer.vim'
""To search files very quickly
Plugin 'wincent/command-t'
""Collection of color schemes for VIM
""echo colorscheme ir_black  >> ~/.vimrc.local
Plugin 'spf13/vim-colors'

""not very good
Plugin 'winmanager'
""insert completion
""help ins-completion
Plugin 'supertab'

Plugin 'steffanc/cscopemaps.vim'

Plugin 'bronson/vim-trailing-whitespace'

"Plugin 'fatih/vim-go'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
"Plugins End

"
"vim-autotags
"
let g:autotags_pathhash_humanreadable = 1
let g:autotags_no_global = 0
let g:autotags_ctags_global_include = "/usr/include/*"
let g:autotags_cscope_exe = "cscope"
let g:autotags_cscope_file_extensions = ".cpp .cc .cxx .m .hpp .hh .h .hxx .c .idl"
let g:autotags_ctags_global_include = "/usr/include/*"
"set to 1 to export $CSCOPE_DIR during initialization and tags build
let g:autotags_export_cscope_dir = 0

"
"nerdtree plugin configuration
"
"open/close NERDTree with Ctrl+n
map <C-n> :NERDTreeToggle<CR>
"close vim if the only window left open is a NERDTree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
"open a NERDTree automatically when vim starts up if no files were specified
"autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

"
"tagbar plugin configuration
"
"open and close Tagbar by simply pressing the <F9> key
nnoremap <silent> <F9> :TagbarToggle<CR>

"
"mru plugin configuration
"

"
"Powerline plugin configuration
"
set laststatus=2
set encoding=utf-8
set t_Co=256
set guifont=PowerlineSymbols\ for\ Powerline
let g:Powerline_symbols='unicode'

"
"YouCompleteMe
"
"let g:ycm_global_ycm_extra_conf = '~'
"let g:ycm_show_diagnostics_ui = 0
" fix hang problem
"let b:ycm_largefile=1

"
"syntastic
"
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 0
let g:syntastic_check_on_wq = 0

"
"color
"
"let g:molokai_original = 1
"let g:rehash256 = 1

"
"airline
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'

"autosess
let g:autosess_dir = '~/.vim/autosess/'

" session related.
" " Default session is located `~/.session_'. The suffix `_' is a dirty
" " solution, just like the one-element tuple `(tuple_eliment,)' in Python..
cnoremap <C-O> source ~/.session_
cnoremap <C-S> mksession! ~/.session_
nnoremap <silent> <C-S><C-S> :mksession! ~/.session_ <CR>

"
" file header setting
"
autocmd BufNewFile *.h so ~/tmp/header.txt
autocmd BufNewFile *.c so ~/tmp/header.txt
autocmd BufNewFile *.cc so ~/tmp/header.txt
autocmd BufNewFile *.cpp so ~/tmp/header.txt
autocmd BufWritePre,FileWritePre *.c execute "normal ma"
autocmd BufWritePost,FileWritePost *.c execute "normal 'a'"

"
" setting for PaperColor
"
"set t_Co=256   " This is may or may not needed.

"set background=dark
"colorscheme PaperColor


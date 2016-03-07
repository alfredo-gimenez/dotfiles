set nocompatible               " be iMproved
filetype off                   " required!

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle
" required! 
Bundle 'VundleVim/Vundle.vim.git'

" github bundles
Bundle 'powerline/powerline'
Bundle 'altercation/vim-colors-solarized'
Bundle 'tpope/vim-fugitive'
Bundle 'tpope/vim-sensible.git'
Bundle 'bling/vim-airline.git'
Bundle 'scrooloose/nerdtree.git'
Bundle 'scrooloose/syntastic.git'
Bundle 'chrisbra/csv.vim'
" Bundle 'kien/ctrlp.vim.git'
Bundle 'Valloric/YouCompleteMe'
" Bundle 'kien/ctrlp.vim'
" Bundle 'L9'
" Bundle 'FuzzyFinder'
Bundle 'klen/python-mode'
Bundle 'davidhalter/jedi-vim'

" non github repos
" Bundle 'git://git.wincent.com/command-t.git'
" ...

filetype plugin indent on     " required!
"
" Brief help
" :BundleList          - list configured bundles
" :BundleInstall(!)    - install(update) bundles
" :BundleSearch(!) foo - search(or refresh cache first) for foo
" :BundleClean(!)      - confirm(or auto-approve) removal of unused bundles
"
" see :h vundle for more details or wiki for FAQ
" NOTE: comments after Bundle command are not allowed..

call vundle#end()

" Colors
syntax enable
set background=dark
colorscheme solarized

" Tabs
set tabstop=4
set shiftwidth=4
set expandtab
set smarttab

" Line numbers duh
set number

" Case searching ignore+smart
set ignorecase
set smartcase

" Mouse (non-gui mode)
set mouse=a

" Replace word under cursor using \s
nnoremap <Leader>s :%s/\<<C-r><C-w>\>/

" Auto-load global ycm conf file [YouCompleteMe]
let g:ycm_confirm_extra_conf = 0
au FileType cc,cpp,hpp let g:ycm_global_ycm_extra_conf = '~/.vim/.ycm_extra_conf_cpp.py'
au FileType c,h let g:ycm_global_ycm_extra_conf = '~/.vim/.ycm_extra_conf_c.py'

" Auto-open NERDTree
autocmd VimEnter * NERDTree

" Switch to code window
autocmd VimEnter * wincmd l

" Update every 1/10 of a second
autocmd VimEnter * set updatetime=100

" CTRLP working path mode
let g:ctrlp_working_path_mode = 0

" Autoload cscope if it exists
cscope add cscope.out

" Cscope key bindings
" A couple of very commonly used cscope queries (using ":cs find") is to
" find all functions calling a certain function and to find all occurrences
" of a particular C symbol.  To do this, you can use these mappings as an
" example: >

	map <C-]> :cs find g <C-R>=expand("<cword>")<CR><CR>
	map <C-\> :cs find 0 <C-R>=expand("<cword>")<CR><CR>

" These mappings for Ctrl-] (right bracket) and Ctrl-\ (backslash) allow you to
" place your cursor over the function name or C symbol and quickly query cscope
" for any matches.
 
" Or you may use the following scheme, inspired by Vim/Cscope tutorial from
" Cscope Home Page (http://cscope.sourceforge.net/): >

	nmap <C-_>s :cs find s <C-R>=expand("<cword>")<CR><CR>
	nmap <C-_>g :cs find g <C-R>=expand("<cword>")<CR><CR>
	nmap <C-_>c :cs find c <C-R>=expand("<cword>")<CR><CR>
	nmap <C-_>t :cs find t <C-R>=expand("<cword>")<CR><CR>
	nmap <C-_>e :cs find e <C-R>=expand("<cword>")<CR><CR>
	nmap <C-_>f :cs find f <C-R>=expand("<cfile>")<CR><CR>
	nmap <C-_>i :cs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
	nmap <C-_>d :cs find d <C-R>=expand("<cword>")<CR><CR>

	" Using 'CTRL-spacebar' then a search type makes the vim window
	" split horizontally, with search result displayed in
	" the new window.

	nmap <C-Space>s :scs find s <C-R>=expand("<cword>")<CR><CR>
	nmap <C-Space>g :scs find g <C-R>=expand("<cword>")<CR><CR>
	nmap <C-Space>c :scs find c <C-R>=expand("<cword>")<CR><CR>
	nmap <C-Space>t :scs find t <C-R>=expand("<cword>")<CR><CR>
	nmap <C-Space>e :scs find e <C-R>=expand("<cword>")<CR><CR>
	nmap <C-Space>f :scs find f <C-R>=expand("<cfile>")<CR><CR>
	nmap <C-Space>i :scs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
	nmap <C-Space>d :scs find d <C-R>=expand("<cword>")<CR><CR>

	" Hitting CTRL-space *twice* before the search type does a vertical
	" split instead of a horizontal one

	nmap <C-Space><C-Space>s
		\:vert scs find s <C-R>=expand("<cword>")<CR><CR>
	nmap <C-Space><C-Space>g
		\:vert scs find g <C-R>=expand("<cword>")<CR><CR>
	nmap <C-Space><C-Space>c
		\:vert scs find c <C-R>=expand("<cword>")<CR><CR>
	nmap <C-Space><C-Space>t
		\:vert scs find t <C-R>=expand("<cword>")<CR><CR>
	nmap <C-Space><C-Space>e
		\:vert scs find e <C-R>=expand("<cword>")<CR><CR>
	nmap <C-Space><C-Space>i
		\:vert scs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
	nmap <C-Space><C-Space>d
		\:vert scs find d <C-R>=expand("<cword>")<CR><CR>

" Python-mode
" Keys:
" K             Show python docs
" <Ctrl-Space>  Rope autocomplete
" <Ctrl-c>g     Rope goto definition
" <Ctrl-c>d     Rope show documentation
" <Ctrl-c>f     Rope find occurrences
" <Leader>b     Set, unset breakpoint (g:pymode_breakpoint enabled)
" [[            Jump on previous class or function (normal, visual, operator modes)
" ]]            Jump on next class or function (normal, visual, operator modes)
" [M            Jump on previous class or method (normal, visual, operator modes)
" ]M            Jump on next class or method (normal, visual, operator modes)

" Rope or Jedi-Vim
let g:pymode_rope = 0 " Jedi-Vim
"let g:pymode_rope = 1 " Rope

" Documentation
let g:pymode_doc = 1
let g:pymode_doc_key = 'K'

" Linting
let g:pymode_lint = 1
let g:pymode_lint_checker = "pyflakes,pep8"

" Auto check on save
let g:pymode_lint_write = 1

" Support virtualenv
let g:pymode_virtualenv = 1

" Enable breakpoints plugin
let g:pymode_breakpoint = 1
let g:pymode_breakpoint_bind = '<leader>b'

" Syntax Highlighting
let g:pymode_syntax = 1
let g:pymode_syntax_all = 1
let g:pymode_syntax_indent_errors = g:pymode_syntax_all
let g:pymode_syntax_space_errors = g:pymode_syntax_all

" Don't autofold code
let g:pymode_folding = 0

" Pep8 line width up to 120, ignore "function too complex"
let g:pep8_ignore="E501,W601,W0612"
let g:syntastic_python_flake8_args="--ignore=E501,W601,W0612"
let g:pymode_options_max_line_length=120
autocmd FileType python set colorcolumn=120

" No X11, use mouse
if has("gui_running")
else 
    set mouse=a
endif

set nocompatible
set autoindent
set smartindent

set tabstop=2
set shiftwidth=2
set number

set showmatch
set incsearch
set ignorecase

set nobackup
set autochdir

syntax on
filetype on
filetype indent on
filetype plugin on
colorscheme railscasts

set encoding=utf-8
set termencoding=utf-8
set fileencoding=utf-8

" first, enable status line always
set laststatus=2
set statusline=%<%f\ %y\ %{VCSCommandGetStatusLine()}\ %h%m%r%=%l,%c%V\ %P

if has("gui_running")
	" GUI is running or is about to start.
	" Maximize gvim window.
	set lines=50 columns=160
	set guifont=Monaco:h12
	set guioptions-=T  
	set visualbell
	set colorcolumn=80
	hi ColorColumn guibg=#444444 ctermbg=246
endif

" FuzzyFinder
nmap <leader>e :FufFile<CR>
nmap <leader>b :FufBuffer<CR>

" Rails
let s:handler = {}
function s:handler.onComplete(item, method)
	execute ":e " . RailsRoot() . "/app/models/" . a:item
endfunctio

fun! MyTest()
	let dir = expand(RailsRoot() . "/app/models/")
	call fuf#callbackitem#launch("", 0, '>', s:handler, split(glob('`(cd ' . dir.  ' && find . -type f | sed "s/^..//")`'), "\n"), 0)
endf

autocmd User Rails nnoremap <leader>c :call MyTest()<CR>

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
	" set lines=50 columns=160
	set guifont=Monaco:h12
	set guioptions-=T  
	set visualbell
	set colorcolumn=80
	hi ColorColumn guibg=#444444 ctermbg=246
endif

" FuzzyFinder
let g:fuf_abbrevMap = {
	\ "^a:" : [
	\   "~/apps/",
	\ ],
	\}
nmap <leader>e :FufFile<CR>
nmap <leader>b :FufBuffer<CR>

" Rails
fun! s:create_listener(dir)
	let listener = {}
	let listener.dir = a:dir
	fun listener.onComplete(item, method)
		execute ":tabfind " . self.dir . "/" . a:item
	endf
	return listener
endf

fun! MyLauncher(dir)
	let d = expand(RailsRoot() . a:dir)
	let files = substitute(glob("`find " . d . " -type f`"), d . "/", '', 'g')
	call fuf#callbackitem#launch("", 0, '>', s:create_listener(d), split(files, "\n"), 0)
endf

autocmd User Rails nnoremap <leader>M :call MyLauncher("/app/models/")<CR>
autocmd User Rails nnoremap <leader>H :call MyLauncher("/app/helpers/")<CR>
autocmd User Rails nnoremap <leader>C :call MyLauncher("/app/controllers/")<CR>
autocmd User Rails nnoremap <leader>V :call MyLauncher("/app/views/")<CR>
autocmd User Rails nnoremap <leader>L :call MyLauncher("/lib/")<CR>
autocmd User Rails nnoremap <leader>F :call MyLauncher("/config/")<CR>
autocmd User Rails nnoremap <leader>T :call MyLauncher("/test/")<CR>
autocmd User Rails nnoremap <leader>R :call MyLauncher("/spec/")<CR>


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
if exists("+autochdir")
	set autochdir
endif

syntax on
filetype on
filetype indent on
filetype plugin on
colorscheme railscasts

set encoding=utf-8
set termencoding=utf-8
set fileencoding=utf-8

set autowrite
set autowriteall

" first, enable status line always
set laststatus=2
set statusline=%<%f\ %y\ %h%m%r%=%l,%c%V\ %P

" fold
set nofoldenable
set foldmethod=syntax
set foldlevel=1
set foldnestmax=2
set foldtext=strpart(getline(v:foldstart),0,50).'\ ...\ '.substitute(getline(v:foldend),'^[\ #]*','','g').'\ '

" save/restore cursor position
set viewoptions=cursor
au BufWritePost,BufLeave,WinLeave ?* mkview
au BufWinEnter ?* silent loadview

" completions
set wildmode=list:longest,list:full
set complete=.,w,t

if has("gui_running")
	" GUI is running or is about to start.
	" Maximize gvim window.
	" set lines=50 columns=160
	set guifont=Monaco:h12
	set guioptions-=T  
	set visualbell
	
	set colorcolumn=80
	hi ColorColumn guibg=#444444 ctermbg=246
	
	" fullscreen options
 	set fuoptions=maxvert,maxhorz
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
		execute ":find " . self.dir . "/" . a:item
	endf
	return listener
endf

fun! RailsFuzzyLaunch(dir)
	let d = expand(RailsRoot() . a:dir)
	let cmd = "`find " . d . " -type f ! -regex \"^.*\/[.#~].*$\"`"
	let files = substitute(glob(cmd), d . "/", '', 'g')
	if empty(files)
		echo "empty"
	else
		call fuf#callbackitem#launch("", 0, '>', s:create_listener(d), split(files, "\n"), 0)
	endif
endf

autocmd User Rails nnoremap <space>m :call RailsFuzzyLaunch("/app/models")<CR>
autocmd User Rails nnoremap <space>h :call RailsFuzzyLaunch("/app/helpers")<CR>
autocmd User Rails nnoremap <space>c :call RailsFuzzyLaunch("/app/controllers")<CR>
autocmd User Rails nnoremap <space>v :call RailsFuzzyLaunch("/app/views")<CR>
autocmd User Rails nnoremap <space>l :call RailsFuzzyLaunch("/lib")<CR>
autocmd User Rails nnoremap <space>f :call RailsFuzzyLaunch("/config/")<CR>
autocmd User Rails nnoremap <space>t :call RailsFuzzyLaunch("/test")<CR>
autocmd User Rails nnoremap <space>s :call RailsFuzzyLaunch("/spec")<CR>
autocmd User Rails nnoremap <space>i :call RailsFuzzyLaunch("/app/mailers")<CR>
autocmd User Rails nnoremap <space>r :call RailsFuzzyLaunch("/")<CR>


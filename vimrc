call pathogen#infect()

set nocompatible
set autoindent
set smartindent

set tabstop=2
set shiftwidth=2
set expandtab
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
hi Normal guibg=#1B2426

set encoding=utf-8

set termencoding=utf-8
set fileencoding=utf-8

set autowrite
set autowriteall

" first, enable status line always
set laststatus=2
set statusline=%<%f\ %y\ %{GitBranch()}\ %h%m%r%=%l,%c%V\ %P

" syntastic
let g:syntastic_enable_signs=1

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

" clipboard sharing in OSX (MacVim)
set clipboard=unnamed

" completions
set wildmode=list:longest,list:full
set complete=.,w,t

set scrolloff=5
set sidescrolloff=7
set sidescroll=1

if has("gui_running")
	" GUI is running or is about to start.
	" Maximize gvim window.
	set guifont=Monaco:h13

	set guioptions-=T " disable toolbar
	set guioptions-=h " disable hscroll
	set guioptions-=v " disable vscroll

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

let g:fuf_modesDisable = ["mrucmd"]

nmap <leader>e :FufFile<CR>
nmap <leader>b :FufBuffer<CR>
nmap <leader>R :FufMruFile<CR>

" command-t
nmap <silent> <leader>t :CommandT<CR>
let g:CommandTMaxHeight=25
let g:CommandTMaxDepth=8
let g:CommandTMaxFiles=1000


" Rails
fun! RailsFuzzyLaunch(dir)
  execute ":CommandT " . RailsRoot() . a:dir
endf

" actionscript
au BufNewFile,BufRead *.as	setf actionscript

augroup MyRails
  autocmd!
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
  autocmd User Rails nnoremap <space>g :call RailsFuzzyLaunch("/db/migrate")<CR>
  autocmd User Rails nnoremap <space>j :call RailsFuzzyLaunch("/app/assets/javascripts")<CR>
  autocmd User Rails map <D-r> :Rake<CR>
augroup end

augroup MyRailsFt
  autocmd!
  autocmd BufNewFile,BufRead */app/models/*.rb       if exists("b:rails_root") | set ft+=.rails_model      | endif
  autocmd BufNewFile,BufRead */app/helpers/*.rb      if exists("b:rails_root") | set ft+=.rails_helper     | endif
  autocmd BufNewFile,BufRead */app/controllers/*.rb  if exists("b:rails_root") | set ft+=.rails_controller | endif
  autocmd BufNewFile,BufRead */spec/*.rb             if exists("b:rails_root") | set ft+=.rspec            | endif
  autocmd BufNewFile,BufRead */spec/models/*.rb      if exists("b:rails_root") | set ft+=.rspec_model      | endif
  autocmd BufNewFile,BufRead */spec/controllers/*.rb if exists("b:rails_root") | set ft+=.rspec_controller | endif
  autocmd BufNewFile,BufRead */spec/helpers/*.rb     if exists("b:rails_root") | set ft+=.rspec_helper     | endif
  autocmd BufNewFile,BufRead */db/migrate/*.rb       if exists("b:rails_root") | set ft+=.rails_migration  | endif
augroup end

" Ruby
augroup MyRubyFt
  autocmd!
  autocmd BufNewFile,BufRead *.rake set ft+=.rake
augroup end

augroup MyRuby
  autocmd!
  autocmd FileType cucumber compiler cucumber | setl makeprg=cucumber\ \"%:p\"
  autocmd FileType ruby
        \ if expand('%') =~# '_test\.rb$' |
        \   compiler rubyunit | setl makeprg=testrb\ \"%:p\" |
        \ elseif expand('%') =~# '_spec\.rb$' |
        \   compiler rspec | setl makeprg=rspec\ \"%:p\" |
        \ else |
        \   compiler ruby | setl makeprg=ruby\ -w\ \"%:p\" |
        \ endif
augroup end

" Whitespaces
function! StripTrailingWhitespace()
  if !&binary && &filetype != 'diff'
  	%s/\s\+$//e
  endif
endfunction

function! StatuslineCurrentHighlight()
	name = synIDattr(synID(line('.'),col('.'),1),'name')
	if name == ''
		return ''
	else
		return '[' . name . ']'
	endif
endfunction

" remap enter/shift-enter to insert blank lines
map <S-Enter> O<Esc>
map <CR> o<Esc>

" remap tab to indent block
map <TAB> V=<Esc>^
"imap <TAB> <Esc>V=<Esc>^

autocmd BufWritePre * :call StripTrailingWhitespace()

" snipMate
let g:snippets_dir = "~/.vim/snipmate.snippets"
"call ReloadAllSnippets()

" NERDTree
let g:NERDTreeDirArrows=1
let g:NERDTreeMinimalUI=1

runtime autoload/pathogen.vim
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

set background=dark
"hi Normal guibg=#1B2426
if has("gui_running")
  colorscheme solarized
  "colorscheme codeschool

  " clojure fixes
  hi! link clojureParen Normal
  hi! link clojureDefine Normal
  hi! link clojureSpecial Normal
  hi! link clojureMacro Normal
endif

set encoding=utf-8

set termencoding=utf-8
set fileencoding=utf-8

set autowrite
set autowriteall

  "" fix slow rendering
  ""set synmaxcol=128
  ""set nocursorcolumn
  ""set nocursorline
  ""set lazyredraw

" This makes vim act like all other editors, buffers can
" exist in the background without being in a window.
" http://items.sjbach.com/319/configuring-vim-right
set hidden

" Turn Off Swap Files
set noswapfile
set nobackup
set nowb

" Keep undo history across sessions, by storing in file.
" Only works all the time.
silent !mkdir ~/.vim/backups > /dev/null 2>&1
set undodir=~/.vim/backups
set undofile

" first, enable status line always
set laststatus=2
" set statusline=%<%f\ %y\ %{GitBranch()}\ %h%m%r%=%l,%c%V\ %P

" power line
"let g:Powerline_symbols = 'compatible'
"call Pl#Theme#RemoveSegment('lineinfo')
let g:airline_left_sep=''
let g:airline_right_sep=''
let g:airline_inactive_collapse=1
let g:airline_section_z = '%3p%%' " disable line number

" syntastic
let g:syntastic_enable_signs=1

" clipboard sharing in OSX (MacVim)
set clipboard=unnamed

" grep
set grepprg=ack
set grepformat=%f:%l:%m

" completions
set wildmode=list:longest,list:full
set wildmenu
set complete=.,t

let g:SuperTabDefaultCompletionType = "context"
let g:SuperTabNoCompleteAfter = [',', '\s', ';', '/', '^']

set scrolloff=5
set sidescrolloff=7
set sidescroll=1

" save on focus lost
au FocusLost * :wa

if has("gui_running")
  " GUI is running or is about to start.
  " Maximize gvim window.
  set guifont=Monaco:h13

  set guioptions-=T " disable toolbar
  set guioptions-=h " disable hscroll
  set guioptions-=v " disable vscroll
  set guioptions-=r " disable right scrollbar
  set guioptions-=L " disable left scrollbar

  set visualbell

  set colorcolumn=80
  hi ColorColumn guibg=#444444 ctermbg=246

  " fullscreen options
  set fuoptions=maxvert,maxhorz
endif

" when we reload, tell vim to restore the cursor to the saved position
augroup JumpCursorOnEdit
  autocmd!
  autocmd BufReadPost *
        \ if expand("<afile>:p:h") !=? $TEMP |
        \ if line("'\"") > 1 && line("'\"") <= line("$") |
        \ let JumpCursorOnEdit_foo = line("'\"") |
        \ let b:doopenfold = 1 |
        \ if (foldlevel(JumpCursorOnEdit_foo) > foldlevel(JumpCursorOnEdit_foo - 1)) |
        \ let JumpCursorOnEdit_foo = JumpCursorOnEdit_foo - 1 |
        \ let b:doopenfold = 2 |
        \ endif |
        \ exe JumpCursorOnEdit_foo |
        \ endif |
        \ endif
  " Need to postpone using "zv" until after reading the modelines.
  autocmd BufWinEnter *
        \ if exists("b:doopenfold") |
        \ exe "normal zv" |
        \ if(b:doopenfold > 1) |
        \ exe "+".1 |
        \ endif |
        \ unlet b:doopenfold |
        \ endif
augroup end

" ignore in finders
set wildignore+=app/assets/images/**

" actionscript
au BufNewFile,BufRead *.as	setf actionscript

" go
augroup MyGoFt
  autocmd!
  autocmd FileType go if expand("%") =~ "_test.go" | set ft+=.go_test | endif
augroup end


" Rails
fun! RailsFuzzyLaunch(dir)
  execute ":CtrlP " . RailsRoot() . a:dir
endf

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
augroup end

augroup MyRailsFt
  autocmd!
  autocmd User Rails if expand("%:p") =~ "/app/models/"       | set ft+=.rails_model      | endif
  autocmd User Rails if expand("%:p") =~ "/app/helpers/"      | set ft+=.rails_helper     | endif
  autocmd User Rails if expand("%:p") =~ "/app/controllers/"  | set ft+=.rails_controller | endif
  autocmd User Rails if expand("%:p") =~ "/spec/models/"      | set ft+=.rspec_model      | endif
  autocmd User Rails if expand("%:p") =~ "/spec/controllers/" | set ft+=.rspec_controller | endif
  autocmd User Rails if expand("%:p") =~ "/spec/helpers/"     | set ft+=.rspec_helper     | endif
  autocmd User Rails if expand("%:p") =~ "/db/migrate/"       | set ft+=.rails_migration  | endif
augroup end

" Ruby
augroup MyRubyFt
  autocmd!
  autocmd BufNewFile,BufRead *.rake    set ft+=.rake
  autocmd BufNewFile,BufRead *_spec.rb set ft+=.rspec
augroup end

" Whitespaces
function! StripTrailingWhitespace()
  if !&binary && &filetype != 'diff'
    %s/\s\+$//e
  endif
endfunction
autocmd BufWritePre * :call StripTrailingWhitespace()

" remap enter/shift-enter to insert blank lines
map <S-Enter> O<Esc>
map <CR> o<Esc>

" remap tab to indent block
map <TAB> V=<Esc>^
"imap <TAB> <Esc>V=<Esc>^

" snipMate
let g:snippets_dir = "~/.vim/snipmate.snippets"
" call ReloadAllSnippets()

" NERDTree
let g:NERDTreeDirArrows=1
let g:NERDTreeMinimalUI=1

imap <C-h> <ESC>^
imap <C-l> <ESC>$

" CtrlP
let mapleader = ","
let g:mapleader = ","

nnoremap <leader>t :CtrlP<CR>
nnoremap <leader>r :CtrlPMRU<CR>
nmap <silent> <leader>m :CtrlPBuffer<CR>

" git blame hitghtlited lines
vmap <leader>g :<C-U>!git blame <C-R>=expand("%:p") <CR> \| sed -n <C-R>=line("'<") <CR>,<C-R>=line("'>") <CR>p <CR>

nmap <silent> <leader>p :NERDTreeToggle<CR>

" Switch between last two buffers
nnoremap <leader><leader> <c-^>

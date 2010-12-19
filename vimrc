set nocompatible
set autoindent
set smartindent

set tabstop=2
set shiftwidth=2
set number

set showmatch
set incsearch

set nobackup

colorscheme railscast

set encoding=utf-8
set termencoding=utf-8
set fileencoding=utf-8

if has("gui_running")
	" GUI is running or is about to start.
	" Maximize gvim window.
	set lines=50 columns=160
  set guifont=Monaco:h12
	set guioptions-=T  
	set visualbell
endif

function! IndentAndComplete()
	if strpart(getline('.'), 0, col('.') - 1) =~ '^\s*'
	 return "\<==>"
	endif
	return "\<tab>"
endfunction



.PHONY: all

all: bundle/Vundle.vim

install:
	vim +PluginInstall +qall

bundle:
	mkdir bundle

bundle/Vundle.vim: bundle
	git clone https://github.com/gmarik/Vundle.vim.git bundle/Vundle.vim

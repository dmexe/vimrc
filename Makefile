WGET=wget --no-check-certificate -q
GIT=git
NULL=/dev/null
SHELL=`which bash`

PATHOGEN=autoload/pathogen.vim

BUNDLES=bundle/vim-snipmate.git \
				bundle/supertab.git \
				bundle/delimitMate.git \
				bundle/Simple-Javascript-Indenter.git \
				bundle/vim-rails.git \
				bundle/vim-ruby.git \
				bundle/vim-coffee-script.git \
				bundle/syntastic.git \
				bundle/vim-jade.git \
				bundle/nerdtree.git \
				bundle/vim-endwise.git \
				bundle/vim-powerline.git \
				bundle/vim-fugitive.git \
				bundle/vim-camelcasemotion.git \
				bundle/vim-colors-solarized.git \
				bundle/ctrlp.vim.git \
				bundle/mv-vim-puppet.git \
				bundle/nerdcommenter.git \
				bundle/ack.vim.git \
				bundle/vim-surround.git \
				bundle/tabular.git \
				bundle/vim-golang.git \
				bundle/tlib_vim.git \
				bundle/vim-addon-mw-utils.git \
				bundle/vim-protobuf.git

download=@echo download $(2) \($(1)\); $(WGET) $(1) -O - > $(2)
gitco=@echo fetch $(2) \($(1)\);\
			if test -d $(2) ;\
			then (cd $(2) && $(GIT) pull --rebase > $(NULL)) ;\
			else $(GIT) clone -q $(1) $(2) > $(NULL) ;\
			fi

all: $(PATHOGEN) $(BUNDLES) $(HOME)/.vimrc

bundle autoload:
	mkdir -p $@

bundles: $(BUNDLES)

$(PATHOGEN): autoload
	$(call download,https://raw.github.com/tpope/vim-pathogen/HEAD/autoload/pathogen.vim,$@)

bundle/tlib_vim.git: bundle
	$(call gitco,https://github.com/tomtom/tlib_vim.git,$@)

bundle/vim-addon-mw-utils.git: bundle
	$(call gitco,https://github.com/MarcWeber/vim-addon-mw-utils.git,$@)

bundle/vim-snipmate.git: bundle/tlib_vim.git bundle/vim-addon-mw-utils.git
	$(call gitco,git://github.com/garbas/vim-snipmate.git,$@)

bundle/supertab.git: bundle
	$(call gitco,git://github.com/ervandew/supertab.git,$@)

bundle/delimitMate.git: bundle
	$(call gitco,git://github.com/Raimondi/delimitMate.git,$@)

bundle/Simple-Javascript-Indenter.git: bundle
	$(call gitco,git://github.com/vim-scripts/Simple-Javascript-Indenter.git,$@)

bundle/vim-rails.git: bundle
	$(call gitco,git://github.com/tpope/vim-rails.git,$@)

bundle/vim-ruby.git: bundle
	$(call gitco,git://github.com/vim-ruby/vim-ruby.git,$@)

bundle/vim-coffee-script.git: bundle
	$(call gitco,git://github.com/kchmck/vim-coffee-script,$@)

bundle/syntastic.git: bundle
	$(call gitco,git://github.com/scrooloose/syntastic.git,$@)

bundle/vim-jade.git: bundle
	$(call gitco,git://github.com/digitaltoad/vim-jade.git,$@)

bundle/nerdtree.git: bundle
	$(call gitco,git://github.com/scrooloose/nerdtree.git,$@)

bundle/vim-endwise.git: bundle
	$(call gitco,git://github.com/tpope/vim-endwise.git,$@)

bundle/vim-powerline.git: bundle
	$(call gitco,git://github.com/Lokaltog/vim-powerline.git,$@)

bundle/vim-fugitive.git: bundle
	$(call gitco,git://github.com/tpope/vim-fugitive.git,$@)

bundle/vim-camelcasemotion.git: bundle
	$(call gitco,git://github.com/ujihisa/camelcasemotion.git,$@)

bundle/vim-colors-solarized.git: bundle
	$(call gitco,git://github.com/altercation/vim-colors-solarized.git,$@)

bundle/ctrlp.vim.git: bundle
	$(call gitco,git://github.com/kien/ctrlp.vim.git,$@)

bundle/mv-vim-puppet.git: bundle
	$(call gitco,git://github.com/mv/mv-vim-puppet.git,$@)

bundle/nerdcommenter.git: bundle
	$(call gitco,git@github.com:scrooloose/nerdcommenter.git,$@)

bundle/ack.vim.git: bundle
	$(call gitco,git@github.com:mileszs/ack.vim.git,$@)

bundle/vim-surround.git: bundle
	$(call gitco,git@github.com:tpope/vim-surround.git,$@)

bundle/tabular.git: bundle
	$(call gitco,git://github.com/godlygeek/tabular.git,$@)

bundle/vim-golang.git: bundle
	$(call gitco,git://github.com/jnwhiteh/vim-golang.git,$@)

bundle/vim-protobuf.git: bundle
	$(call gitco,https://github.com/uarun/vim-protobuf.git, $@)

clean:
	@for i in $(PATHOGEN) ; do \
	echo rm $$i ; \
	rm -f $$i ; \
	done
	@for i in $(BUNDLES) ; do \
	echo rm $$i ; \
	rm -rf $$i ; \
	done
	@echo rm snippets
	@rm -f snippets
	@echo rmdir autoload
	@rmdir autoload

$(HOME)/.vimrc:
	@echo link $@
	@ln -sf `pwd`/vimrc $(HOME)/.vimrc



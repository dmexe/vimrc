WGET=wget --no-check-certificate -q
GIT=git
NULL=/dev/null
SHELL=`which bash`

PATHOGEN=autoload/pathogen.vim

BUNDLES=bundle/vim-railscasts-theme.git \
				bundle/snipmate.vim.git \
				bundle/supertab.git \
				bundle/delimitMate.git \
				bundle/FuzzyFinder.git \
				bundle/L9.git \
				bundle/Simple-Javascript-Indenter.git \
				bundle/javaScriptLint.vim.git \
				bundle/vim-rails.git \
				bundle/vim-ruby.git \
				bundle/command-t.git \
				bundle/vim-coffee-script.git \
				bundle/syntastic.git \
				bundle/vim-jade.git \
				bundle/nerdtree.git \
				bundle/vim-endwise.git \
				bundle/vim-powerline.git \
				bundle/vim-fugitive.git

EXTENSIONS=bundle/command-t.git/ruby/command-t/ext.bundle

download=@echo download $(2) \($(1)\); $(WGET) $(1) -O - > $(2)
gitco=@echo fetch $(2) \($(1)\);\
			if test -d $(2) ;\
			then (cd $(2) && $(GIT) pull --rebase > $(NULL)) ;\
			else $(GIT) clone -q $(1) $(2) > $(NULL) ;\
			fi

all: $(PATHOGEN) $(BUNDLES) $(EXTENSIONS) $(HOME)/.vimrc

bundle autoload:
	mkdir -p $@

bundles: $(BUNDLES)

$(PATHOGEN): autoload
	$(call download,https://raw.github.com/tpope/vim-pathogen/HEAD/autoload/pathogen.vim,$@)

bundle/vim-railscasts-theme.git: bundle
	$(call gitco,git://github.com/jpo/vim-railscasts-theme.git,$@)

bundle/snipmate.vim.git: bundle
	$(call gitco,git://github.com/msanders/snipmate.vim.git,$@)

bundle/supertab.git: bundle
	$(call gitco,git://github.com/ervandew/supertab.git,$@)

bundle/delimitMate.git: bundle
	$(call gitco,git://github.com/Raimondi/delimitMate.git,$@)

bundle/FuzzyFinder.git: bundle
	$(call gitco,git://github.com/vim-scripts/FuzzyFinder.git,$@)

bundle/L9.git: bundle
	$(call gitco,git://github.com/vim-scripts/L9.git,$@)

bundle/Simple-Javascript-Indenter.git: bundle
	$(call gitco,git://github.com/vim-scripts/Simple-Javascript-Indenter.git,$@)

bundle/javaScriptLint.vim.git: bundle
	$(call gitco,git://github.com/joestelmach/javaScriptLint.vim.git,$@)

bundle/vim-rails.git: bundle
	$(call gitco,git://github.com/tpope/vim-rails.git,$@)

bundle/vim-ruby.git: bundle
	$(call gitco,git://github.com/vim-ruby/vim-ruby.git,$@)

bundle/command-t.git/ruby/command-t/ext.bundle: bundle/command-t.git bundle/command-t.git/ruby/command-t/ext.c
	@echo build $@ extension
	@(cd bundle/command-t.git && rake make -q)

bundle/command-t.git: bundle
	$(call gitco,git://git.wincent.com/command-t.git,$@)

bundle/vim-coffee-script.git: bundle
	$(call gitco,git://github.com/kchmck/vim-coffee-script,$@)

bundle/syntastic.git: bundle
	$(call gitco,git://github.com/scrooloose/syntastic.git,$@)

bundle/UltiSnips.git: bundle
	$(call gitco,git://github.com/vim-scripts/UltiSnips.git,$@)

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




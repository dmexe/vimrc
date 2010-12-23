WGET=wget --no-check-certificate
GIT=git
NULL=/dev/null
SHELL=`which bash`

WORK_DIRS=after \
autoload \
backups \
bundles \
colors \
doc \
ftplugin \
plugin \
snippets \
syntax \
nerdtree_plugin \
bin \
compiler \
etc \
ftdetect \
indent


SNIPMATE_FILES=after/plugin/snipMate.vim \
autoload/snipMate.vim \
doc/snipMate.txt \
ftplugin/html_snip_helper.vim \
plugin/snipMate.vim


SUPERTAB_FILES=plugin/supertab.vim

NERDTREE_FILES=doc/NERD_tree.txt \
nerdtree_plugin/exec_menuitem.vim \
nerdtree_plugin/fs_menu.vim \
plugin/NERD_tree.vim

DELIMIT_FILES=autoload/delimitMate.vim \
autoload/delimitMateTests.vim \
doc/delimitMate.txt \
plugin/delimitMate.vim

FUZZYFINDER_FILES=autoload/fuf/bookmarkdir.vim \
autoload/fuf/bookmarkfile.vim \
autoload/fuf/buffer.vim \
autoload/fuf/buffertag.vim \
autoload/fuf/callbackfile.vim \
autoload/fuf/callbackitem.vim \
autoload/fuf/changelist.vim \
autoload/fuf/coveragefile.vim \
autoload/fuf/dir.vim \
autoload/fuf/file.vim \
autoload/fuf/givencmd.vim \
autoload/fuf/givendir.vim \
autoload/fuf/givenfile.vim \
autoload/fuf/help.vim \
autoload/fuf/jumplist.vim \
autoload/fuf/line.vim \
autoload/fuf/mrucmd.vim \
autoload/fuf/mrufile.vim \
autoload/fuf/quickfix.vim \
autoload/fuf/tag.vim \
autoload/fuf/taggedfile.vim \
autoload/fuf.vim \
doc/fuf.jax \
doc/fuf.txt \
plugin/fuf.vim

L9_FILES=autoload/l9.vim \
autoload/l9/async.py \
autoload/l9/async.vim \
autoload/l9/quickfix.vim \
autoload/l9/tempbuffer.vim \
autoload/l9/tempvariables.vim \
doc/l9.jax \
doc/l9.txt \
plugin/l9.vim

RAILS_FILES=autoload/rails.vim \
doc/rails.txt \
plugin/rails.vim

RUBY_FILES=autoload/rubycomplete.vim \
bin/vim-ruby-install.rb \
compiler/eruby.vim \
compiler/rspec.vim \
compiler/ruby.vim \
compiler/rubyunit.vim \
doc/ft-ruby-omni.txt \
doc/ft-ruby-syntax.txt \
etc/release/cvsrelease \
etc/release/README \
etc/release/release.sh \
etc/website/djk-theme.css \
etc/website/index.html \
etc/website/update.sh \
ftdetect/ruby.vim \
ftplugin/eruby.vim \
ftplugin/ruby.vim \
indent/eruby.vim \
indent/ruby.vim \
syntax/eruby.vim \
syntax/ruby.vim

NERDCOMMENTER_FILES=doc/NERD_commenter.txt \
plugin/NERD_commenter.vim

WEB_INDENT_FILES=indent/javascript.vim \
indent/html.vim

GIT_FILES=doc/git-vim.txt \
plugin/git.vim \
syntax/git-diff.vim \
syntax/git-log.vim \
syntax/git-status.vim

all: bundles colors \
$(HOME)/.vimrc \
colors/railscasts.vim \
snippets \
$(SNIPMATE_FILES) \
$(SUPERTAB_FILES) \
$(NERDTREE_FILES) \
$(DELIMIT_FILES) \
$(FUZZYFINDER_FILES) \
$(L9_FILES) \
$(RAILS_FILES) \
$(RUBY_FILES) \
$(NERDTREE_FILES) \
$(WEB_INDENT_FILES) \
$(GIT_FILES)

clean:
	@for i in $(WORK_DIRS) ; do \
	echo rm $$i ; \
	rm -rf `pwd`/$$i ; \
	done

colors bundles:
	mkdir $@

$(HOME)/.vimrc:
	@echo link $@
	@rm -f $(HOME)/.vimrc
	@ln -s `pwd`/vimrc $(HOME)/.vimrc

bundles/railscast.git: bundles
	@echo fetch $@
	@if test -d $@ ;\
	then (cd $@ && $(GIT) pull --rebase > $(NULL)); \
	else $(GIT) clone git://github.com/jpo/vim-railscasts-theme.git $@ > $(NULL); \
	fi

colors/railscasts.vim: bundles/railscast.git
	@echo link $@
	@rm -f `pwd`/colors/railscast.vim
	@ln -s `pwd`/bundles/railscast.git/railscasts.vim `pwd`/$@

bundles/snipmate.git: bundles
	@echo fetch $@
	@if test -d $@ ;\
	then (cd $@ && $(GIT) pull --rebase > $(NULL)); \
	else $(GIT) clone git://github.com/msanders/snipmate.vim.git $@ > $(NULL); \
	fi

$(SNIPMATE_FILES): bundles/snipmate.git
	@echo install $@
	@mkdir -p `pwd`/`dirname $@`
	@rm -f `pwd`/$@
	@ln -s `pwd`/bundles/snipmate.git/$@ `pwd`/$@

bundles/supertab.git: bundles
	@echo fetch $@
	@if test -d $@ ; \
	then (cd $@ && $(GIT) pull --rebase > $(NULL)); \
	else $(GIT) clone git://github.com/ervandew/supertab.git $@ > $(NULL); \
	fi

$(SUPERTAB_FILES): bundles/supertab.git
	@echo install $@
	@mkdir -p `pwd`/`dirname $@`
	@rm -f `pwd`/$@
	@ln -s `pwd`/bundles/supertab.git/$@ `pwd`/$@

bundles/nerdtree.git: bundles
	@echo fetch $@
	@if test -d $@ ; \
	then (cd $@ && $(GIT) pull --rebase > $(NULL)); \
	else $(GIT) clone git://github.com/scrooloose/nerdtree.git $@ > $(NULL); \
	fi

$(NERDTREE_FILES): bundles/nerdtree.git
	@echo install $@
	@mkdir -p `pwd`/`dirname $@`
	@rm -f `pwd`/$@
	@ln -s `pwd`/bundles/nerdtree.git/$@ `pwd`/$@

bundles/delimitMate.git: bundles
	@echo fetch $@
	@if test -d $@ ; \
	then (cd $@ && $(GIT) pull --rebase > $(NULL)); \
	else $(GIT) clone git://github.com/Raimondi/delimitMate.git $@ > $(NULL); \
	fi

$(DELIMIT_FILES): bundles/delimitMate.git
	@echo install $@
	@mkdir -p `pwd`/`dirname $@`
	@rm -f `pwd`/$@
	@ln -s `pwd`/bundles/delimitMate.git/$@ `pwd`/$@

bundles/fuzzy_finder.git: bundles
	@echo fetch $@
	@if test -d $@ ; \
	then (cd $@ && $(GIT) pull --rebase > $(NULL)); \
	else $(GIT) clone git://github.com/vim-scripts/FuzzyFinder.git $@ > $(NULL); \
	fi

$(FUZZYFINDER_FILES): bundles/fuzzy_finder.git
	@echo install $@
	@mkdir -p `pwd`/`dirname $@`
	@rm -f `pwd`/$@
	@ln -s `pwd`/bundles/fuzzy_finder.git/$@ `pwd`/$@

bundles/l9: bundles
	@echo fetch $@
	@rm -rf `pwd`/$@
	@rm -f `pwd`/$@.zip
	$(WGET) -O $@.zip http://www.vim.org/scripts/download_script.php?src_id=13948
	mkdir -p $@
	(cd $@ && unzip ../l9.zip)

$(L9_FILES): bundles/l9
	@echo install $@
	@mkdir -p `pwd`/`dirname $@`
	@rm -f `pwd`/$@
	@ln -s `pwd`/bundles/l9/$@ `pwd`/$@

bundles/web-indent: bundles
	@echo fetch $@
	@rm -rf `pwd`/$@
	@rm -f `pwd`/$@.zip
	$(WGET) -O $@.zip http://www.vim.org/scripts/download_script.php?src_id=13006
	mkdir -p $@
	(cd $@ && unzip ../web-indent.zip)

$(WEB_INDENT_FILES): bundles/web-indent
	@echo install $@
	@mkdir -p `pwd`/`dirname $@`
	@rm -f `pwd`/$@
	@ln -s `pwd`/bundles/web-indent/$@ `pwd`/$@


bundles/rails.git: bundles
	@echo fetch $@
	@if test -d $@ ; \
	then (cd $@ && $(GIT) pull --rebase > $(NULL)); \
	else $(GIT) clone git://github.com/tpope/vim-rails.git $@ > $(NULL); \
	fi

$(RAILS_FILES): bundles/rails.git
	@echo install $@
	@mkdir -p `pwd`/`dirname $@`
	@rm -f `pwd`/$@
	@ln -s `pwd`/bundles/rails.git/$@ `pwd`/$@

bundles/ruby.git: bundles
	@echo fetch $@
	@if test -d $@ ; \
	then (cd $@ && $(GIT) pull --rebase > $(NULL)); \
	else $(GIT) clone git://github.com/vim-ruby/vim-ruby.git $@ > $(NULL); \
	fi

$(RUBY_FILES): bundles/ruby.git
	@echo install $@
	@mkdir -p `pwd`/`dirname $@`
	@rm -f `pwd`/$@
	@ln -s `pwd`/bundles/ruby.git/$@ `pwd`/$@

bundles/nerdcommenter.git: bundles
	@echo fetch $@
	@if test -d $@ ; \
	then (cd $@ && $(GIT) pull --rebase > $(NULL)); \
	else $(GIT) clone git://github.com/scrooloose/nerdcommenter.git $@ > $(NULL); \
	fi

$(NERDCOMMENTER_FILES): bundles/nerdcommenter.git
	@echo install $@
	@mkdir -p `pwd`/`dirname $@`
	@rm -f `pwd`/$@
	@ln -s `pwd`/bundles/nerdcommenter.git/$@ `pwd`/$@

bundles/git.git: bundles
	@echo fetch $@
	@if test -d $@ ; \
	then (cd $@ && $(GIT) pull --rebase > $(NULL)); \
	else $(GIT) clone git://github.com/motemen/git-vim.git $@ > $(NULL); \
	fi

$(GIT_FILES): bundles/git.git
	@echo install $@
	@mkdir -p `pwd`/`dirname $@`
	@rm -f `pwd`/$@
	@ln -s `pwd`/bundles/git.git/$@ `pwd`/$@

bundles/snipmate-snippets.git: bundles
	@echo fetch $@
	@if test -d $@ ; \
	then (cd $@ && $(GIT) pull --rebase > $(NULL)); \
	else $(GIT) clone git://github.com/dima-exe/snipmate-snippets.git $@ > $(NULL); \
	fi

snippets: bundles/snipmate-snippets.git
	@echo link $@
	@ln -s `pwd`/bundles/snipmate-snippets.git $@

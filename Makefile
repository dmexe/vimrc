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
nerdtree_plugin

SNIPMATE_FILES=after/plugin/snipMate.vim \
autoload/snipMate.vim \
doc/snipMate.txt \
ftplugin/html_snip_helper.vim \
plugin/snipMate.vim \
snippets/_.snippets \
snippets/autoit.snippets \
snippets/c.snippets \
snippets/cpp.snippets \
snippets/erlang.snippets \
snippets/html.snippets \
snippets/java.snippets \
snippets/javascript.snippets \
snippets/mako.snippets \
snippets/objc.snippets \
snippets/perl.snippets \
snippets/php.snippets \
snippets/python.snippets \
snippets/ruby.snippets \
snippets/sh.snippets \
snippets/snippet.snippets \
snippets/tcl.snippets \
snippets/tex.snippets \
snippets/vim.snippets \
snippets/zsh.snippets \
syntax/snippet.vim

SUPERTAB_FILES=plugin/supertab.vim

NERDTREE_FILES=doc/NERD_tree.txt \
nerdtree_plugin/exec_menuitem.vim \
nerdtree_plugin/fs_menu.vim \
plugin/NERD_tree.vim

VCSCOMMAND_FILES=doc/vcscommand.txt \
plugin/vcsbzr.vim \
plugin/vcscommand.vim \
plugin/vcscvs.vim \
plugin/vcsgit.vim \
plugin/vcshg.vim \
plugin/vcssvk.vim \
plugin/vcssvn.vim \
syntax/cvsannotate.vim \
syntax/gitannotate.vim \
syntax/hgannotate.vim \
syntax/svkannotate.vim \
syntax/svnannotate.vim \
syntax/vcscommit.vim

DELIMIT_FILES=autoload/delimitMate.vim \
autoload/delimitMateTests.vim \
doc/delimitMate.txt \
plugin/delimitMate.vim

all: bundles colors \
$(HOME)/.vimrc \
colors/railscast.vim \
$(SNIPMATE_FILES) \
$(SUPERTAB_FILES) \
$(NERDTREE_FILES) \
$(VCSCOMMAND_FILES) \
$(DELIMIT_FILES)

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

colors/railscast.vim: bundles/railscast.git
	@echo link $@
	@rm -f `pwd`/colors/railscast.vim
	@ln -s `pwd`/bundles/railscast.git/railscasts.vim `pwd`/colors/railscast.vim

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

bundles/vcscommand.git: bundles
	@echo fetch $@
	@if test -d $@ ; \
	then (cd $@ && $(GIT) pull --rebase > $(NULL)); \
	else $(GIT) clone git://repo.or.cz/vcscommand $@ > $(NULL); \
	fi

$(VCSCOMMAND_FILES): bundles/vcscommand.git
	@echo install $@
	@mkdir -p `pwd`/`dirname $@`
	@rm -f `pwd`/$@
	@ln -s `pwd`/bundles/vcscommand.git/$@ `pwd`/$@

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

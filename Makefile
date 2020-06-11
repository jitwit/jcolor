
.PHONY : clean

all : README.md jcolor.ijs

jcolor.ijs : README.org
	emacs $< --batch \
		--eval "(progn (require 'package)(package-initialize)(require 'org))" \
		--eval "(org-babel-tangle)"

README.md : README.org
	emacs $< --batch \
		--eval "(progn (require 'package)(package-initialize)(require 'org)(require 'ox-gfm))" \
		--eval "(org-gfm-export-to-markdown nil nil nil)"

clean :
	rm -rf *~


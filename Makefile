.PHONY: clean
.PHONY: all
.DEFAULT_GOAL := all

LATEXMK=latexmk ${MKOPTS}
MKOPTS= -pdf

EDMARK=activateeditingmarks

ROOT_DIR:=$(shell dirname $(realpath $(firstword $(MAKEFILE_LIST))))

writing := $(wildcard *.tex)

plots:
	$(ROOT_DIR)/data/twitter_bench/generate.sh $(ROOT_DIR)/data/twitter_bench
	$(ROOT_DIR)/data/point_corr/generate.sh $(ROOT_DIR)/data/point_corr
	$(ROOT_DIR)/data/racketcore/generate.sh $(ROOT_DIR)/data/racketcore
	$(ROOT_DIR)/data/coursecompiler/generate.sh $(ROOT_DIR)/data/coursecompiler

ed: editingmarks
editingmarks:
	touch $(EDMARK)
	${LATEXMK} -g thesis.tex

plain:
	rm -f $(EDMARK)
	${LATEXMK} -g thesis.tex

all: $(writing) plots
	${LATEXMK} thesis.tex

clean: 
	latexmk -C
	rm twitter_slowdown_plot.*
	rm point_corr_plot.*

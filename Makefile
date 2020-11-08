.PHONY: clean
.PHONY: all
.DEFAULT_GOAL := all

LATEXMK=latexmk ${MKOPTS}
MKOPTS= -pdf

EDMARK=activateeditingmarks

ROOT_DIR:=$(shell dirname $(realpath $(firstword $(MAKEFILE_LIST))))

writing := $(wildcard *.tex)

plot1:
	$(ROOT_DIR)/data/twitter_bench/generate.sh $(ROOT_DIR)/data/twitter_bench

plot2:
	$(ROOT_DIR)/data/point_corr/generate.sh $(ROOT_DIR)/data/point_corr

plot3:
	$(ROOT_DIR)/data/racketcore/generate.sh $(ROOT_DIR)/data/racketcore

ed: editingmarks
editingmarks:
	touch $(EDMARK)
	${LATEXMK} -g thesis.tex

plain:
	rm -f $(EDMARK)
	${LATEXMK} -g thesis.tex

all: $(writing) plot1 plot2
	${LATEXMK} thesis.tex

clean: 
	latexmk -C
	rm twitter_slowdown_plot.*
	rm point_corr_plot.*

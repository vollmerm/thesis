.PHONY: clean
.PHONY: all
.DEFAULT_GOAL := all

ROOT_DIR:=$(shell dirname $(realpath $(firstword $(MAKEFILE_LIST))))

writing := $(wildcard *.tex)

plot1: data/twitter_bench/*.csv
	$(ROOT_DIR)/data/twitter_bench/generate.sh $(ROOT_DIR)/data/twitter_bench

plot2: data/point_corr/point_corr.dat
	$(ROOT_DIR)/data/point_corr/generate.sh $(ROOT_DIR)/data/point_corr

all: $(writing) plot1 plot2
	latexmk thesis.tex -pdf

clean: 
	latexmk -C
	rm twitter_slowdown_plot.*
	rm point_corr_plot.*

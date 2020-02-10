.PHONY: clean

writing := $(wildcard *.tex)

thesis: $(writing) 
	latexmk thesis.tex -pdf

clean: 
	latexmk -C

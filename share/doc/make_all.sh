#!/bin/bash

pdflatex -interaction=nonstopmode overview.tex
pdflatex -interaction=nonstopmode overview.tex
pdflatex -interaction=nonstopmode overview.tex


rm -f *.aux
rm -f *.log
rm -f *.nav
rm -f *.out
rm -f *.snm
rm -f *.toc

mv overview.pdf dia-simplemusic/overview.pdf




#!/bin/bash

set -e
set -o pipefail

DATA_DIR=$1

gnuplot -e "data_dir='$DATA_DIR'" $DATA_DIR/coursecompiler.gpi

cp $DATA_DIR/coursecompiler_plot.tex ./
cp $DATA_DIR/coursecompiler_plot.eps ./

#!/bin/bash

set -e
set -o pipefail

DATA_DIR=$1

gnuplot -e "data_dir='$DATA_DIR'" $DATA_DIR/point_corr.gpi

cp $DATA_DIR/point_corr_plot.tex ./
cp $DATA_DIR/point_corr_plot.eps ./

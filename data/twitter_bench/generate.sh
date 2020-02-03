#!/bin/bash

set -e
set -o pipefail

DATA_DIR=$1

gnuplot -e "data_dir='$DATA_DIR'" $DATA_DIR/twitter_slowdown_plot.gpi

cp $DATA_DIR/twitter_slowdown_plot.tex ./
cp $DATA_DIR/twitter_slowdown_plot.eps ./

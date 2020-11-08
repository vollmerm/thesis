#!/usr/bin/env bash
set -euo pipefail

DATA_DIR=$1

gnuplot -e "data_dir='$DATA_DIR'" $DATA_DIR/slowdown_countnodes.gpi
gnuplot -e "data_dir='$DATA_DIR'" $DATA_DIR/slowdown_treewalk.gpi

cp $DATA_DIR/slowdown_countnodes_plot.tex ./
cp $DATA_DIR/slowdown_countnodes_plot.eps ./
cp $DATA_DIR/slowdown_treewalk_plot.tex ./
cp $DATA_DIR/slowdown_treewalk_plot.eps ./

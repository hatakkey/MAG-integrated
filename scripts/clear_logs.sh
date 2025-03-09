#!/bin/bash

## clear open5gs log files
for filename in ../logs/*.log; do
    > "$filename"
done

## clear bngblaster log files
for filename in ../configs/bngblaster/*.log; do
    > "$filename"
done


#!/bin/bash

# jenky way to grab all the preset names. I'd rather use jq, but I can't be bothered to lookup the needed syntax rn.
for preset in $(sed -n 's/": {//;s/^        "//p;' wheelchairHandleDeterrent.json); do
    openscad -o "build/$preset.stl" -p wheelchairHandleDeterrent.json -P "$preset" wheelchairHandleDeterrent.scad
done

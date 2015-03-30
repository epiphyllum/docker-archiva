#!/bin/bash


for dir in `ls assets/split`; do
    cat assets/split/$dir/x* > assets/packages/$dir
done



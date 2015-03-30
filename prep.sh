#!/bin/bash


mkdir -p assets/packages;
for dir in `ls assets/split`; do
    name=${dir//-split};
    cat assets/split/$dir/x* > assets/packages/$name
done



#!/bin/bash

name=$1
if [[ -e $name ]] ; then
    i=0
    while [[ -e $name-$i ]] ; do
        let i++
    done
    name=$name-$i
fi
echo "$name"
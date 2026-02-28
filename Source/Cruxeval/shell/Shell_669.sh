#!/bin/bash
# $1 is a string
f() {
    a=$(echo $1 | rev | awk -F'-' '{print $3}' | rev)
    sep="-"
    b=$(echo $1 | rev | awk -F'-' '{print $1}' | rev)
    
    if [ ${#b} -eq ${#a} ]; then
        echo 'imbalanced'
    else
        echo $a$(echo $b | sed "s/$sep//g")
    fi
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "fubarbaz") = "fubarbaz" ]]
}

run_test

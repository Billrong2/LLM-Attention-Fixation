#!/bin/bash
# $1 is a two column CSV in key,value order
f() {
    echo "" > $1
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "a,3
b,-1
c,Dum") = "" ]]
}

run_test

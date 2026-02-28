#!/bin/bash
# $1 is a string
f() {
    sample=$1
    i=-1
    while [ "${sample:$i+1}" != "" ]; do
        i=$(($i+1))
        if [ "${sample:$i:1}" = "/" ]; then
            i=$(($i+1))
            break
        fi
    done
    echo $(($i-1))
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "present/here/car%2Fwe") = "7" ]]
}

run_test

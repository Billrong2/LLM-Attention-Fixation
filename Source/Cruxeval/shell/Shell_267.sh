#!/bin/bash
# $1 is a string
# $2 is an integer
f() {
    if [ $2 -lt 0 ]; then
        echo $1
    else
        len=${#1}
        space=$(( len/2 + $2 ))
        printf "%-${space}s" "$1"
    fi
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "sowpf" "-7") = "sowpf" ]]
}

run_test

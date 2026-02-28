#!/bin/bash
# $1 is a space-separated list
f() {
    IFS=' ' read -r -a nums <<< "$1"
    a=-1
    b=("${nums[@]:1}")

    while [ $a -le ${b[0]} ]; do
        nums=(${nums[@]/${b[0]}/})
        a=0
        b=("${b[@]:1}")
    done

    echo "${nums[@]}"
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "-1 5 3 -2 -6 8 8") = "-1 -2 -6 8 8" ]]
}

run_test

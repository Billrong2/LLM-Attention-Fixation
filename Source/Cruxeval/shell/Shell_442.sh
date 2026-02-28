#!/bin/bash
# $1 is a space-separated list
f() {
    lst=($1)
    res=()
    for i in ${!lst[@]}; do
        if (( ${lst[$i]} % 2 == 0 )); then
            res+=(${lst[$i]})
        fi
    done
    echo ${lst[@]}
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "1 2 3 4") = "1 2 3 4" ]]
}

run_test

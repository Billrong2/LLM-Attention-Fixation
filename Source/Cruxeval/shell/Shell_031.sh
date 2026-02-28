#!/bin/bash
# $1 is a string
f() {
    upper=0
    for ((i=0; i<${#1}; i++)); do
        if [[ ${1:i:1} == [[:upper:]] ]]; then
            upper=$((upper+1))
        fi
    done

    if [[ $((upper % 2)) -eq 0 ]]; then
        echo $((upper * 2))
    else
        echo $upper
    fi
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "PoIOarTvpoead") = "8" ]]
}

run_test

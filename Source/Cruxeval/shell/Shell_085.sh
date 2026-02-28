#!/bin/bash
# $1 is an integer
f() {
    n=$1
    declare -A values
    values[0]=3
    values[1]=4.5
    values[2]='-'
    declare -A res
    for i in "${!values[@]}"; do
        if (($i % $n != 2)); then
            res[${values[$i]}]=$(($n / 2))
        fi
    done
    sorted_res=$(for key in "${!res[@]}"; do echo $key; done | sort -n)
    echo $sorted_res
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "12") = "3 4.5" ]]
}

run_test

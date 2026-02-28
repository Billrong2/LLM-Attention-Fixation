#!/bin/bash
# $1 is a space-separated list
f() {
    nums=($1)
    for num in ${nums[@]}; do
        if [ $((num % 3)) -eq 0 ]; then
            nums+=($num)
        fi
    done
    echo ${nums[@]}
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "1 3") = "1 3 3" ]]
}

run_test

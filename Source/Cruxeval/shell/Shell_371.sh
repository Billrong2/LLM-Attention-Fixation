#!/bin/bash
# $1 is a space-separated list
f() {
    nums=($1)
    new_nums=()
    for num in "${nums[@]}"; do
        if [ $((num % 2)) -eq 0 ]; then
            new_nums+=($num)
        fi
    done

    sum_=0
    for num in "${new_nums[@]}"; do
        sum_=$((sum_ + num))
    done

    echo $sum_
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "11 21 0 11") = "0" ]]
}

run_test

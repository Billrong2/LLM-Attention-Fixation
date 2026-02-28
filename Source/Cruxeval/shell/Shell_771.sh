#!/bin/bash
# $1 is a space-separated list
f() {
    items=($1)
    sorted_items=($(for item in "${items[@]}"; do echo $item; done | sort -n))
    odd_positioned=()
    for i in $(seq 1 2 ${#sorted_items[@]}); do
        odd_positioned+=(${sorted_items[$i]})
    done
    echo ${odd_positioned[@]}
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "1 2 3 4 5 6 7 8") = "2 4 6 8" ]]
}

run_test

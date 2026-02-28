#!/bin/bash
# $1 is a space-separated list
# $2 is an integer
f() {
    nums=($1)
    target=$2
    count=0
    for n1 in "${nums[@]}"; do
        for n2 in "${nums[@]}"; do
            if [ $((n1 + n2)) -eq $target ]; then
                ((count++))
            fi
        done
    done
    echo $count
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "1 2 3" "4") = "3" ]]
}

run_test

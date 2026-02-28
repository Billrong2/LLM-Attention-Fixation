#!/bin/bash
# $1 is a space-separated list
f() {
    local counts=0
    for i in $1; do
        if [[ $i =~ ^[0-9]+$ ]]; then
            if [ $counts -eq 0 ]; then
                counts=$((counts + 1))
            fi
        fi
    done
    echo $counts
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "0 6 2 -1 -2") = "1" ]]
}

run_test

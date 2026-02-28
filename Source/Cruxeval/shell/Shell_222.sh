#!/bin/bash
# $1 is a string
# $2 is a string
f() {
    while [[ $(echo $1 | grep -o $2 | wc -l) -gt 1 ]]; do
        pos=$(echo $1 | grep -o $2 | tail -n 1)
        start=$(expr $pos + 1)
        end=$(expr $start + 1)
        part1=$(echo $1 | cut -c 1-$pos)
        part2=$(echo $1 | cut -c $end-)
        result=$part1$part2
        set -- "$result"
    done
    echo $1
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "0aabbaa0b" "a") = "0aabbaa0b" ]]
}

run_test

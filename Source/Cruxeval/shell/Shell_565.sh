#!/bin/bash
# $1 is a string
f() {
    text=$1
    max_pos=-1
    for ch in a e i o u; do
        pos=$(expr index "$text" $ch)
        if [ $pos -gt $max_pos ]; then
            max_pos=$pos
        fi
    done
    echo $((max_pos - 1))
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "qsqgijwmmhbchoj") = "13" ]]
}

run_test

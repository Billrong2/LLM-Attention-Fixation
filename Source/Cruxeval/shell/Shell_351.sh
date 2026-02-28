#!/bin/bash
# $1 is a string
f() {
    local text=$1
    while [[ $text == *"nnet lloP"* ]]; do
        text=${text//nnet lloP/nnet loLp}
    done
    echo "$text"
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "a_A_b_B3 ") = "a_A_b_B3 " ]]
}

run_test

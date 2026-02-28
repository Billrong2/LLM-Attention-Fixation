#!/bin/bash
# $1 is an argument
f() {
    if [[ $(declare -p $1 2>/dev/null) =~ "declare -A" ]]; then
        amount=${#1[@]}
    elif [[ $(declare -p $1 2>/dev/null) =~ "declare -a" ]]; then
        amount=${#1[@]}
    else
        amount=0
    fi

    nonzero=$((amount > 0 ? amount : 0))
    echo $nonzero
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "1") = "0" ]]
}

run_test

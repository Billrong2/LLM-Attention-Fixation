#!/bin/bash
# $1 is a string
# $2 is a string
f() {
    text=$1
    value=$2
    length=${#text}
    letters=($(echo "$text" | grep -o .))
    if [[ ! " ${letters[@]} " =~ " $value " ]]; then
        value=${letters[0]}
    fi
    echo $(printf "%0.s$value" $(seq 1 $length))
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "ldebgp o" "o") = "oooooooo" ]]
}

run_test

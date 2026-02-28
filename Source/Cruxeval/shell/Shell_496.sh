#!/bin/bash
# $1 is a string
# $2 is a string
f() {
    text=$1
    value=$2
    if [[ $value =~ ^[0-9]+$ ]]; then
        echo $(grep -o $value <<< $text | wc -l)
    else
        echo $(( $(grep -io $value <<< $text | wc -l) + $(grep -io ${value,,} <<< $text | wc -l) ))
    fi
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "eftw{ьТсk_1" "\\") = "0" ]]
}

run_test

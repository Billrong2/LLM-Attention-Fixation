#!/bin/bash
# $1 is a string
# $2 is a string
f() {
    text=$1
    value=$2
    ls=($(echo $text | sed 's/./&\n/g'))

    if [ $(( $(echo ${ls[@]} | grep -o $value | wc -l) % 2 )) -eq 0 ]; then
        ls=($(echo ${ls[@]} | tr -d "$value"))
    else
        ls=()
    fi

    echo ${ls[@]} | tr -d ' '
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "abbkebaniuwurzvr" "m") = "abbkebaniuwurzvr" ]]
}

run_test

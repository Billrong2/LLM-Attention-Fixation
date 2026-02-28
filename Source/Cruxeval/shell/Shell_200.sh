#!/bin/bash
# $1 is a string
# $2 is a string
f() {
    text=$1
    value=$2
    length=${#text}
    index=0

    while [ $length -gt 0 ]; do
        value="${text:$index:1}$value"
        length=$((length - 1))
        index=$((index + 1))
    done

    echo $value
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "jao mt" "house") = "tm oajhouse" ]]
}

run_test

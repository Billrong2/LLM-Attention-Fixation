#!/bin/bash
# $1 is a string
# $2 is a string
f() {
    text=$1
    prefix=$2
    prefix_length=${#prefix}
    if [[ $text == $prefix* ]]; then
        echo ${text:($prefix_length - 1) / 2:($prefix_length + 1) / 2 * -1:1}
    else
        echo $text
    fi
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "happy" "ha") = "" ]]
}

run_test

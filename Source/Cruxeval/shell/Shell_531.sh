#!/bin/bash
# $1 is a string
# $2 is a string
f() {
    text=$1
    x=$2
    if [[ "${text#$x}" == "$text" ]]; then
        f "${text:1}" "$x"
    else
        echo "$text"
    fi
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "Ibaskdjgblw asdl " "djgblw") = "djgblw asdl " ]]
}

run_test

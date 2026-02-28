#!/bin/bash
# $1 is a string
# $2 is a string
f() {
    text=$(echo $1 | sed "s/^[$2]*//;s/[$2]*$//")
    echo $text
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "0 t 1cos " "st 0	\n  ") = "1co" ]]
}

run_test

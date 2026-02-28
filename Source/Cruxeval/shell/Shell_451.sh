#!/bin/bash
# $1 is a string
# $2 is a string
f() {
    text=$1
    char=$2
    text=$(echo $text | sed "s/$char//")
    echo $text
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "pn" "p") = "n" ]]
}

run_test

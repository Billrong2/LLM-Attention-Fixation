#!/bin/bash
# $1 is a string
f() {
    text=$(echo $1 | tr '[:upper:]' '[:lower:]')
    head=$(echo $text | cut -c1 | tr '[:lower:]' '[:upper:]')
    tail=$(echo $text | cut -c2-)
    echo "${head}${tail}"
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "Manolo") = "Manolo" ]]
}

run_test

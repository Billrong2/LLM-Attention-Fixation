#!/bin/bash
# $1 is a string
# $2 is a string
f() {
    text=$1
    delimiter=$2
    result=$(echo $text | rev | awk -F$delimiter '{print $1}' | rev)
    echo "${text%"$delimiter$result"}$result"
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "xxjarczx" "x") = "xxjarcz" ]]
}

run_test

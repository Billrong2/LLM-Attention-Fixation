#!/bin/bash
# $1 is a string
# $2 is a string
f() {
    if [[ $1 == *$2 ]]; then
        text=${1%${2}}$(echo ${1: -1} | tr 'a-z' 'A-Z')
    fi
    echo $text
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "damdrodm" "m") = "damdrodM" ]]
}

run_test

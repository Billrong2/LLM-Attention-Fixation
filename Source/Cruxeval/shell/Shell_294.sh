#!/bin/bash
# $1 is a string
# $2 is a string
# $3 is a string
f() {
    if [[ -z "${3// }" ]]; then
        echo "$3"
    else
        head="${3:0:1}"
        mid="${3:1:${#3}-2}"
        tail="${3: -1}"
        joined="${head//$1/$2}${mid//$1/$2}${tail//$1/$2}"
        echo "$joined"
    fi
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "x" "\$" "2xz&5H3*1a@#a*1hris") = "2\$z&5H3*1a@#a*1hris" ]]
}

run_test

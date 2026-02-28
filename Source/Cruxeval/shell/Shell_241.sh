#!/bin/bash
# $1 is a string
f() {
    postcode=$1
    char_index=${postcode%%C*}
    char_index=${#char_index}
    echo ${postcode:char_index}
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "ED20 CW") = "CW" ]]
}

run_test

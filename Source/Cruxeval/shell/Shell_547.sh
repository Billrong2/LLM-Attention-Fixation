#!/bin/bash

# $1 is a string
f() {
    letters_only=$(echo $1 | sed 's/^[.,!?*]*//;s/[.,!?*]*$//')
    echo $letters_only | sed 's/ /.... /g'
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "h,e,l,l,o,wo,r,ld,") = "h,e,l,l,o,wo,r,ld" ]]
}

run_test

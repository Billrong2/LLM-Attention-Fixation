#!/bin/bash
# $1 is a string
f() {
    string=$1
    string_no_slashn=${string//\\n/}
    echo ${#string_no_slashn}
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "n wez szize lnson tilebi it 504n.\n") = "33" ]]
}

run_test

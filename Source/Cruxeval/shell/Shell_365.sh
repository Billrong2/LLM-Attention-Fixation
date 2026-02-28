#!/bin/bash
# $1 is a string
# $2 is a string
f() {
    if [[ $2 == $1* ]]; then
        pre=${2%%$1*}
        echo "$pre$1${2:${#1}}"
    else
        echo "$2"
    fi
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "xqc" "mRcwVqXsRDRb") = "mRcwVqXsRDRb" ]]
}

run_test

#!/bin/bash
# $1 is a string
# $2 is a string
# $3 is a string
f() {
    echo "$1" | tr "$2" "$3"
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "mmm34mIm" "mm3" ",po") = "pppo4pIp" ]]
}

run_test

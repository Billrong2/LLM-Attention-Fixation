#!/bin/bash
# $1 is a string
f() {
    echo "$1" | awk '{print tolower($0)}' | sed -e "s/io/IO/g" -e "s/\b\(.\)/\u\1/g"
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "Fu,ux zfujijabji pfu.") = "Fu,Ux Zfujijabji Pfu." ]]
}

run_test

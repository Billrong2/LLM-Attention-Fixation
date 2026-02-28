#!/bin/bash
# $1 is a string
# $2 is a string
f() {
    cnt=$(echo $1 | grep -o "$2" | wc -l)
    result=$(yes "$1$2" | head -n $cnt | tr -d '\n' | rev)
    echo $result
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "caabcfcabfc" "ab") = "bacfbacfcbaacbacfbacfcbaac" ]]
}

run_test

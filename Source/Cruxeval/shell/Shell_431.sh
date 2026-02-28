#!/bin/bash
# $1 is an integer
# $2 is an integer
f() {
    local -a arr
    for (( i=1; i<=$1; i++ )); do
        arr+=($i)
    done
    for (( i=0; i<$2; i++ )); do
        arr=()
    done
    echo "${arr[@]}"
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "1" "3") = "" ]]
}

run_test

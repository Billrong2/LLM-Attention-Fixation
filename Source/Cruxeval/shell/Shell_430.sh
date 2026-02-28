#!/bin/bash
# $1 is a space-separated list
# $2 is a newline-separated, space-separated list
f() {
    arr1=($1)
    arr2=()
    IFS='
'
    read -a arr2 <<< "$2"

    for element in "${arr2[@]}"
    do
        arr1+=("$element")
    done

    echo "${arr1[@]}"
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "5 1 3 7 8" " 0 -1 ") = "5 1 3 7 8  0 -1 " ]]
}

run_test

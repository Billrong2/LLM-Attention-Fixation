#!/bin/bash
# $1 is a space-separated list
# $2 is an integer
# $3 is an integer
f() {
    array=($1)
    index=$2
    value=$3

    array=("${array[@]:0:index}" "$((index + 1))" "${array[@]:index}")

    if [ $value -ge 1 ]; then
        array=("${array[@]:0:index}" "$value" "${array[@]:index}")
    fi

    echo "${array[@]}"
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "2" "0" "2") = "2 1 2" ]]
}

run_test

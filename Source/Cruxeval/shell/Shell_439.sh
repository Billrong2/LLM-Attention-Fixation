#!/bin/bash
# $1 is a string
f() {
    parts=($(echo $1 | awk -F" " '{print $1}'))
    echo ${parts[@]}
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "coscifysu") = "coscifysu" ]]
}

run_test

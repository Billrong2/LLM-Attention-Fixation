#!/bin/bash
# $1 is a string
f() {
    value=$1
    ls=($(echo $value | grep -o .))
    ls+=('NHIB')
    result=$(IFS=; echo "${ls[*]}")
    echo $result
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "ruam") = "ruamNHIB" ]]
}

run_test

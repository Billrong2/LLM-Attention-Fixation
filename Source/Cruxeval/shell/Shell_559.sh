#!/bin/bash
# $1 is a string
f() {
    n=$(echo $1 | sed 's/-/_/g')
    echo "${n:0:1}.${n:1}"
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "first-second-third") = "f.irst_second_third" ]]
}

run_test

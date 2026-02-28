#!/bin/bash
# $1 is a space-separated list
# $2 is an integer
f() {
    local nums=($1)
    local target=$2
    local cnt=$(grep -o $target <<< ${nums[@]} | wc -l)
    echo $(( $cnt * 2 ))
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "1 1" "1") = "4" ]]
}

run_test

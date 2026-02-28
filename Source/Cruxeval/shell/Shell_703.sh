#!/bin/bash
# $1 is a string
# $2 is a string
f() {
    count=$(echo $1 | grep -o $2$2 | wc -l)
    echo ${1:$count}
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "vzzv2sg" "z") = "zzv2sg" ]]
}

run_test

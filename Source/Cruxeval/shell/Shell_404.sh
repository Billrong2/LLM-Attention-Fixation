#!/bin/bash
# $1 is a space-separated list
f() {
    no=($1)
    declare -A d
    for item in "${no[@]}"; do
        d[$item]=false
    done
    count=0
    for key in "${!d[@]}"; do
        ((count++))
    done
    echo $count
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "l f h g s b") = "6" ]]
}

run_test

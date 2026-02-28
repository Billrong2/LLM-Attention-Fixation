#!/bin/bash
# $1 is a space-separated list
# $2 is a string
f() {
    local nums=($1)
    local fill=$2
    local -A ans
    for num in "${nums[@]}"; do
        ans[$num]=$fill
    done
    for key in "${!ans[@]}"; do
        echo "$key,${ans[$key]}"
    done | sort -n
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "0 1 1 2" "abcca") = "0,abcca
1,abcca
2,abcca" ]]
}

run_test

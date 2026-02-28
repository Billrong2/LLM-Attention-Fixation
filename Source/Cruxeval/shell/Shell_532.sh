#!/bin/bash
# $1 is an integer
# $2 is a space-separated list
f() {
    n=$1
    array=($2)
    final=("${array[@]}")
    result=("${array[@]}")
    for ((i=0; i<n; i++)); do
        result+=("${final[@]}")
        final=("${result[@]}")
    done
    for ((i=0; i<=n; i++)); do
        echo "${result[@]:0:${#array[@]}*($i+1)}"
    done
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "1" "1 2 3") = "1 2 3
1 2 3 1 2 3" ]]
}

run_test

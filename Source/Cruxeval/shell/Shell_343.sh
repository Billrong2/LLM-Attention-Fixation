#!/bin/bash
# $1 is a space-separated list
# $2 is a space-separated list
f() {
    local array=($1)
    local elem=($2)
    for e in "${elem[@]}"; do
        array+=("$e")
    done
    echo "${array[@]}"
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "1 2 3 1 2 1" "1 2 3 3 2 1") = "1 2 3 1 2 1 1 2 3 3 2 1" ]]
}

run_test

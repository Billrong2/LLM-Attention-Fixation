#!/bin/bash
# $1 is a space-separated list
f() {
    lst=($1)
    new=()
    i=$((${#lst[@]} - 1))
    for ((j=0; j<${#lst[@]}; j++)); do
        if [ $((i % 2)) -eq 0 ]; then
            new+=($((-${lst[i]})))
        else
            new+=(${lst[i]})
        fi
        i=$((i - 1))
    done
    echo ${new[@]}
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "1 7 -1 -3") = "-3 1 7 -1" ]]
}

run_test

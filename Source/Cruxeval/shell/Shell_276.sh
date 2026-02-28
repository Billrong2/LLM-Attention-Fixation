#!/bin/bash
# $1 is a space-separated list
f() {
    local arr=($1)
    if [ ${#arr[@]} -ge 2 ] && [ ${arr[0]} -gt 0 ] && [ ${arr[1]} -gt 0 ]; then
        arr=($(echo ${arr[@]} | awk '{for (i=NF; i>0; i--) printf("%s ", $i)}'))
        echo "${arr[@]}"
    else
        arr+=("0")
        echo "${arr[@]}"
    fi
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "") = "0" ]]
}

run_test

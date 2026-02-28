#!/bin/bash
# $1 is a space-separated list
# $2 is an integer
f() {
    local array=($1)
    local count=0
    for item in "${array[@]}"; do
        if [ $item -eq $2 ]; then
            ((count++))
        fi
    done
    echo $((count + $2))
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "1 1 1" "-2") = "-2" ]]
}

run_test

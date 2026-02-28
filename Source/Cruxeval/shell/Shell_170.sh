#!/bin/bash
# $1 is a space-separated list
# $2 is an integer
f() {
    local nums=($1)
    local count=0
    for num in "${nums[@]}"; do
        if [ $num -eq $2 ]; then
            ((count++))
        fi
    done
    echo $count
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "12 0 13 4 12" "12") = "2" ]]
}

run_test

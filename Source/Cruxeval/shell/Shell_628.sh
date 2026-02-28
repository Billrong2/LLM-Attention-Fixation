#!/bin/bash
# $1 is a space-separated list
# $2 is an integer
f() {
    local nums=($1)
    local delete=$2
    local result=()

    for num in "${nums[@]}"; do
        if [ $num -ne $delete ]; then
            result+=($num)
        fi
    done

    echo "${result[@]}"
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "4 5 3 6 1" "5") = "4 3 6 1" ]]
}

run_test

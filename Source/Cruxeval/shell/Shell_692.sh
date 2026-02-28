#!/bin/bash
# $1 is a space-separated list
f() {
    reversed_array=$(echo $1 | tr ' ' '\n' | tac | tr '\n' ' ')
    result=()
    for num in $reversed_array; do
        if [ $num -ne 0 ]; then
            result+=($num)
        fi
    done
    reversed_result=$(printf "%s\n" "${result[@]}" | tac | tr '\n' ' ')
    echo $reversed_result
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "") = "" ]]
}

run_test

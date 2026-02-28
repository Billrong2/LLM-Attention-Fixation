#!/bin/bash
# $1 is an integer
f() {
    result=()
    for ((c=1; c<=10; c++)); do
        if [ $c -ne $1 ]; then
            result+=($c)
        fi
    done
    echo "${result[@]}"
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "5") = "1 2 3 4 6 7 8 9 10" ]]
}

run_test

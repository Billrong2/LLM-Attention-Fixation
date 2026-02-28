#!/bin/bash
# $1 is an integer
f() {
    if [ $1 -eq 0 ]; then
        echo 0
    else
        a=$1
        result=()
        while [ $a -gt 0 ]; do
            result+=( $(( $a % 10 )) )
            a=$(( $a / 10 ))
        done
        result=$(printf "%s" "${result[@]}" | tr -d ' ')
        echo $result
    fi
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "0") = "0" ]]
}

run_test

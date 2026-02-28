#!/bin/bash
# $1 is a string
# $2 is a string
f() {
    result=()
    for ((i=0; i<${#1}; i++)); do
        char=${1:i:1}
        uppercase_char=$(echo $char | tr '[:lower:]' '[:upper:]')
        if [[ $2 == *$uppercase_char* ]]; then
            result+=($char)
        fi
    done

    uppercase_input=$(echo $2 | tr '[:lower:]' '[:upper:]')
    if [[ $uppercase_input == $2 ]]; then
        result+=('all_uppercased')
    fi

    echo "${result[@]}"
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "abcdefghijklmnopqrstuvwxyz" "uppercased # % ^ @ \! vz.") = "" ]]
}

run_test

#!/bin/bash
# $1 is a string
# $2 is a string
f() {
    result=$1
    suffix_length=${#2}

    if [ -z "$2" ]; then
        echo $result
    else
        while [[ $result == *"$2" ]]; do
            result=${result%$2}
        done
        echo $result
    fi
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "ababa" "ab") = "ababa" ]]
}

run_test

#!/bin/bash
# $1 is a string
f() {
    result_list=('3' '3' '3' '3')
    if [ ${#result_list[@]} -gt 0 ]; then
        result_list=()
    fi
    echo ${#1}
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "mrq7y") = "5" ]]
}

run_test

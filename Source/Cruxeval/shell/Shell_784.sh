#!/bin/bash
# $1 is a string
# $2 is a string
f() {
    declare -A dict_
    dict_[$1]=$2
    for key in "${!dict_[@]}"; do
        echo "$key ${dict_[$key]}"
    done
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "read" "Is") = "read Is" ]]
}

run_test

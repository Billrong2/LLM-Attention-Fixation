#!/bin/bash
# $1 is a string
f() {
    read -ra my_array <<< "$1"
    for word in "${my_array[@]}"; do
        echo "$word"
    done | sort -r | xargs
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "a loved") = "loved a" ]]
}

run_test

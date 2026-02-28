#!/bin/bash
# $1 is a string
# $2 is a string
f() {
    new_text=$1
    a=()
    while [[ $new_text == *"$2"* ]]; do
        a+=($(expr index "$new_text" "$2" - 1))
        new_text=$(sed "0,/$2/{s///}" <<< "$new_text")
    done
    echo "${a[@]}"
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "rvr" "r") = "0 1" ]]
}

run_test

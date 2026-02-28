#!/bin/bash
# $1 is a space-separated list
f() {
    values=($1)
    names=('Pete' 'Linda' 'Angela')
    for value in "${values[@]}"; do
        names+=("$value")
    done
    IFS=$'\n' sorted=($(sort <<<"${names[*]}"))
    echo "${sorted[@]}"
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "Dan Joe Dusty") = "Angela Dan Dusty Joe Linda Pete" ]]
}

run_test

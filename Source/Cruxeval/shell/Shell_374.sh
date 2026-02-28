#!/bin/bash
# $1 is a space-separated list
# $2 is a string
f() {
    seq=($1)
    v=$2
    a=()
    
    for i in "${seq[@]}"; do
        if [[ "$i" == *"$v" ]]; then
            a+=("$i$i")
        fi
    done
    
    echo "${a[@]}"
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "oH ee mb deft n zz f abA" "zz") = "zzzz" ]]
}

run_test

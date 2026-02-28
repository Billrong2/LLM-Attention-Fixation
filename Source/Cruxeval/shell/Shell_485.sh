#!/bin/bash
# $1 is a string
f() {
    tokens=($1)
    if [ ${#tokens[@]} -eq 2 ]; then
        tmp=${tokens[0]}
        tokens[0]=${tokens[1]}
        tokens[1]=$tmp
    fi
    printf "%-5s %-5s\n" ${tokens[0]} ${tokens[1]}
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "gsd avdropj") = "avdropj gsd  " ]]
}

run_test

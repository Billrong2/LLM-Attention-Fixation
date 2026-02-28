#!/bin/bash
# $1 is a string
# $2 is an integer
f() {
    IFS='
'
    text=( $1 )
    for t in "${text[@]}"; do
        printf "%s\n" "$(printf "%s" "$t" | expand -t $2)"
    done
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "	f9\n	ldf9\n	adf9\!\n	f9?" "1") = " f9\n ldf9\n adf9\!\n f9?" ]]
}

run_test

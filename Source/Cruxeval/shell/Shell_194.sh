#!/bin/bash
# $1 is a newline-separated, space-separated list
# $2 is an integer
f() {
    local matr=()
    local insert_loc=$2
    local IFS=$'\n'
    local i=0

    for line in $1; do
        matr+=("$line")
    done

    if [ "$insert_loc" -ge 0 ] && [ "$insert_loc" -le "${#matr[@]}" ]; then
        matr=("${matr[@]:0:$insert_loc}" "" "${matr[@]:$insert_loc}")
    fi

    for row in "${matr[@]}"; do
        echo "$row"
    done
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "5 6 2 3
1 9 5 6" "0") = "
5 6 2 3
1 9 5 6" ]]
}

run_test

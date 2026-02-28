#!/bin/bash
# $1 is a string
f() {
    text=$1
    i=$(( (${#text} + 1) / 2 ))
    result=($(echo "$text" | grep -o .))
    while [ $i -lt ${#text} ]; do
        t=$(echo "${result[$i]}" | tr '[:upper:]' '[:lower:]')
        if [ "$t" == "${result[$i]}" ]; then
            i=$(( $i + 1 ))
        else
            result[$i]=$t
        fi
        i=$(( $i + 2 ))
    done
    printf "%s" "${result[@]}"
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "mJkLbn") = "mJklbn" ]]
}

run_test

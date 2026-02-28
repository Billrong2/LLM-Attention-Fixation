#!/bin/bash
# $1 is a string
f() {
    text="$1"
    length=${#text}
    for (( i=0; i<length; i++ )); do
        text="${text:0:i}${text:i:1}${text:i}"
    done
    printf "%-$((length * 2))s" "$text"
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "hzcw") = "hhhhhzcw" ]]
}

run_test

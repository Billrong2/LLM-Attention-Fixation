#!/bin/bash
# $1 is a string
f() {
    t=$1
    text=$1
    for i in $(echo $1 | grep -o .); do
        text=$(echo $text | sed "s/$i//g")
    done
    echo ${#text}$t
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "ThisIsSoAtrocious") = "0ThisIsSoAtrocious" ]]
}

run_test

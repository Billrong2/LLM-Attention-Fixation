#!/bin/bash
# $1 is a string
# $2 is a string
f() {
    text=$1
    characters=$2
    for (( i=0; i<${#characters}; i++ ))
    do
        text=$(echo $text | sed "s/[${characters:i:1}]\+$//")
    done
    echo $text
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "r;r;r;r;r;r;r;r;r" "x.r") = "r;r;r;r;r;r;r;r;" ]]
}

run_test

#!/bin/bash
# $1 is a string
# $2 is an integer
f() {
    text=$1
    res=$2
    for c in '*' '\n' '"'; do
        text=$(echo $text | sed "s/$c/!$res/g")
    done
    if [[ $text == !* ]]; then
        text=${text:${#res}}
    fi
    echo $text
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "\"Leap and the net will appear" "123") = "3Leap and the net will appear" ]]
}

run_test

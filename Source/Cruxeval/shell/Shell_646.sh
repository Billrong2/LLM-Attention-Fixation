#!/bin/bash
# $1 is a string
# $2 is an integer
f() {
    text=$1
    count=$2
    for (( i=0; i<$count; i++ ))
    do
        text=$(echo $text | rev)
    done
    echo $text
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "aBc, ,SzY" "2") = "aBc, ,SzY" ]]
}

run_test

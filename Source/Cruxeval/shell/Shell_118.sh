#!/bin/bash
# $1 is a string
# $2 is a string
f() {
    num_applies=2
    extra_chars=''
    for ((i=0; i<num_applies; i++)); do
        extra_chars+=$2
        text=$(echo $1 | sed "s/$extra_chars//g")
    done
    echo $text
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "zbzquiuqnmfkx" "mk") = "zbzquiuqnmfkx" ]]
}

run_test

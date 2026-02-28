#!/bin/bash
# $1 is a string
# $2 is a string
f() {
    text=$1
    letter=$2
    counts=()
    for (( i=0; i<${#text}; i++ )); do
        char=${text:$i:1}
        if [[ -z ${counts[$char]} ]]; then
            counts[$char]=1
        else
            ((counts[$char]++))
        fi
    done
    echo ${counts[$letter]:-0}
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "za1fd1as8f7afasdfam97adfa" "7") = "2" ]]
}

run_test

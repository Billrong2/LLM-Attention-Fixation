#!/bin/bash
# $1 is a string
f() {
    s=0
    for (( i=1; i<${#1}; i++ )); do
        partition=$(echo $1 | awk -v char="${1:i:1}" '{print index($0,char)}')
        s=$(( s + partition - 1 ))
    done
    echo $s
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "wdj") = "3" ]]
}

run_test

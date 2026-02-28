#!/bin/bash
# $1 is a string
# $2 is a string
f() {
    needle=$1
    haystack=$2
    count=0
    while [[ $haystack == *"$needle"* ]]; do
        haystack=${haystack/"$needle"/}
        count=$((count+1))
    done
    echo $count
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "a" "xxxaaxaaxx") = "4" ]]
}

run_test

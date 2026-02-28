#!/bin/bash
# $1 is a string
# $2 is a string
f() {
    tmp=$(echo $2 | rev | sed 's/9/0/g; s/[^0-9]/_/g')
    if [[ $1 =~ ^[0-9]+$ && $tmp =~ ^[0-9]+$ ]]; then
        echo "$1$tmp"
    else
        echo $1
    fi
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "" "sdasdnakjsda80") = "" ]]
}

run_test

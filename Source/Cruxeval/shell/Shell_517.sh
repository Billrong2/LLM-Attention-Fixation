#!/bin/bash
# $1 is a string
f() {
    text=$1
    len=${#text}
    for (( i=$len-1; i>0; i-- )); do
        if [[ ! ${text:i:1} =~ [A-Z] ]]; then
            echo ${text:0:i}
            return
        fi
    done
    echo ""
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "SzHjifnzog") = "SzHjifnzo" ]]
}

run_test

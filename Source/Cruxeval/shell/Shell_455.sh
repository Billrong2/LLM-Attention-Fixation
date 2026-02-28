#!/bin/bash
# $1 is a string
f() {
    uppers=0
    for ((i=0; i<${#1}; i++)); do
        c=${1:i:1}
        if [[ $c =~ [A-Z] ]]; then
            uppers=$((uppers + 1))
        fi
    done
    
    if [ $uppers -ge 10 ]; then
        echo "${1^^}"
    else
        echo "$1"
    fi
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "?XyZ") = "?XyZ" ]]
}

run_test

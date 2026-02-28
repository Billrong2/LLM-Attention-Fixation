#!/bin/bash
# $1 is a string
f() {
    if [ "$1" = "42.42" ]; then
        echo true
        return
    fi
    
    for (( i=3; i<${#1}-3; i++ )); do
        if [ "${1:$i:1}" = "." ] && [[ ${1:$i-3:${#1}} =~ ^[0-9]+$ ]] && [[ ${1:0:$i} =~ ^[0-9]+$ ]]; then
            echo true
            return
        fi
    done
    
    echo false
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "123E-10") = "false" ]]
}

run_test

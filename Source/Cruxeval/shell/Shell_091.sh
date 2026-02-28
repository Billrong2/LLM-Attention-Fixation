#!/bin/bash

f() {
    local str=$1
    local result=""
    for (( i=0; i<${#str}; i++ )); do
        if [[ $result != *"${str:$i:1}"* ]]; then
            result+="${str:$i:1} "
        fi
    done
    echo $result
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "12ab23xy") = "1 2 a b 3 x y" ]]
}

run_test

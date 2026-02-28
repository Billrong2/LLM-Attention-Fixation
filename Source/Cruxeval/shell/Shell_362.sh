#!/bin/bash
# $1 is a string
f() {
    local text=$1
    local len=${#text}
    for (( i=0; i<len-1; i++ )); do
        if [[ $(echo "${text:$i}" | tr -d '\n' | grep -c '^[a-z]*$') -eq 1 ]]; then
            echo "${text:i+1}"
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
    [[ $(candidate "wrazugizoernmgzu") = "razugizoernmgzu" ]]
}

run_test

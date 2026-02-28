#!/bin/bash
# $1 is a two column CSV in key,value order
f() {
    local input="$1"
    local result=""
    while IFS=, read -r key value; do
        if [ "$value" -ge 0 ]; then
            value=$(( -value ))
        fi
        result+="$key,$value"$'\n'
    done < <(echo -e "$input")
    echo -n "$result"
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "R,0
T,3
F,-6
K,0") = "R,0
T,-3
F,-6
K,0" ]]
}

run_test

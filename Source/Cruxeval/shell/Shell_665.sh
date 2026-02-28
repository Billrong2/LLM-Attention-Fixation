#!/bin/bash
# $1 is a string
f() {
    local s=""
    for ((i=0; i<${#1}; i++)); do
        ch=${1:i:1}
        count=$(grep -o $ch <<< $1 | wc -l)
        if [ $(( $count % 2 )) -eq 0 ]; then
            s+=$(echo $ch | tr '[:lower:]' '[:upper:]')
        else
            s+=$ch
        fi
    done
    echo $s
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "acbced") = "aCbCed" ]]
}

run_test

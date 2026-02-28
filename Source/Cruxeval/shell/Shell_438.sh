#!/bin/bash
# $1 is a string
f() {
    local string=$1
    local bigTab=100
    for ((i=10; i<30; i++)); do
        if [[ $(echo "$string" | grep -o $'\t' | wc -l) -gt 0 && $(echo "$string" | grep -o $'\t' | wc -l) -lt 20 ]]; then
            bigTab=$i
            break
        fi
    done
    echo -e "$string" | expand -t $bigTab
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "1  			3") = "1                             3" ]]
}

run_test

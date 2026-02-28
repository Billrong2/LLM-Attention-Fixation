#!/bin/bash
# $1 is a string
f() {
    count=0
    for ((i=0; i<${#1}; i++)); do
        letter=${1:$i:1}
        if [[ $letter =~ [0-9] ]]; then
            ((count++))
        fi
    done
    echo $count
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "dp ef1 gh2") = "2" ]]
}

run_test

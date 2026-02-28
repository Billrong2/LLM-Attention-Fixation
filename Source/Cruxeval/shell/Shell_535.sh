#!/bin/bash
# $1 is an integer
f() {
    n=$1
    for digit in $(echo $n | grep -o .); do
        if [[ ! $digit =~ [0-2] && ($digit -lt 5 || $digit -gt 9) ]]; then
            echo "false"
            return
        fi
    done
    echo "true"
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "1341240312") = "false" ]]
}

run_test

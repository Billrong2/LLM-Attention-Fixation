#!/bin/bash
# $1 is a string
f() {
    x=0
    if echo "$1" | grep -q '^[a-z]*$'; then
        for c in $(echo "$1" | grep -o .); do
            if [ "$c" -ge 0 ] && [ "$c" -lt 90 ]; then
                x=$((x+1))
            fi
        done
    fi
    echo $x
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "591237865") = "0" ]]
}

run_test

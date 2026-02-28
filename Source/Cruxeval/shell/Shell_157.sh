#!/bin/bash
# $1 is a string
f() {
    local phrase=$1
    local ans=0
    for w in $phrase; do
        for (( i=0; i<${#w}; i++ )); do
            if [ "${w:i:1}" = "0" ]; then
                (( ans++ ))
            fi
        done
    done
    echo $ans
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "aboba 212 has 0 digits") = "1" ]]
}

run_test

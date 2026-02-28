#!/bin/bash
# $1 is a string
f() {
    count=0
    digits=""
    for ((i=0; i<${#1}; i++)); do
        c=${1:i:1}
        if [[ $c =~ [0-9] ]]; then
            ((count++))
            digits+=${c}
        fi
    done
    echo "$digits $count"
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "qwfasgahh329kn12a23") = "3291223 7" ]]
}

run_test

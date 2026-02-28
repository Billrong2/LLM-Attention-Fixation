#!/bin/bash
# $1 is a string
f() {
    if [[ $1 == *.* ]]; then
        echo $(echo "scale=1; $1 + 2.5" | bc)
    else
        echo $1
    fi
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "800") = "800" ]]
}

run_test

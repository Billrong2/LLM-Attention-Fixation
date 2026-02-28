#!/bin/bash
# $1 is a space-separated list
f() {
    reversed=$(echo $1 | rev)
    if [ "$reversed" == "$1" ]; then
        echo true
    else
        echo false
    fi
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "0 3 6 2") = "false" ]]
}

run_test

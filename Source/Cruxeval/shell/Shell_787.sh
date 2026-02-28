#!/bin/bash
# $1 is a string
f() {
    if [ -z "$1" ]; then
        echo ''
    else
        text=$(echo "$1" | tr '[:upper:]' '[:lower:]')
        firstChar=$(echo "$text" | cut -c 1 | tr '[:lower:]' '[:upper:]')
        restOfText=$(echo "$text" | cut -c 2-)
        echo "$firstChar$restOfText"
    fi
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "xzd") = "Xzd" ]]
}

run_test

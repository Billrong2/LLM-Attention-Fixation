#!/bin/bash
# $1 is a string
f() {
    text=$1
    minus_count=$(echo "$text" | tr -cd '-' | wc -m)
    length=${#text}
    if [ "$minus_count" -eq "$length" ]; then
        echo "true"
    else
        echo "false"
    fi
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "---123-4") = "false" ]]
}

run_test

#!/bin/bash
# $1 is a string
f() {
    words=($1)
    for word in "${words[@]}"; do
        if ! [[ "$word" =~ ^[0-9]+$ ]]; then
            echo "no"
            return
        fi
    done
    echo "yes"
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "03625163633 d") = "no" ]]
}

run_test

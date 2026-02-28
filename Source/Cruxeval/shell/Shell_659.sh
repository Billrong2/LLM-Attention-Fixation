#!/bin/bash
# $1 is a space-separated list
f() {
    bots=($1)
    clean=()
    for username in "${bots[@]}"; do
        if [[ ! $username =~ ^[A-Z]+$ ]]; then
            clean+=("${username:0:2}${username: -3}")
        fi
    done
    echo ${#clean[@]}
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "yR?TAJhIW?n o11BgEFDfoe KnHdn2vdEd wvwruuqfhXbGis") = "4" ]]
}

run_test

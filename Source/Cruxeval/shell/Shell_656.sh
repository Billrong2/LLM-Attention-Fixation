#!/bin/bash
# $1 is a space-separated list
f() {
    local letters=($1)
    local -a a
    for i in "${!letters[@]}"; do
        if [[ " ${a[@]} " =~ " ${letters[i]} " ]]; then
            echo 'no'
            return
        fi
        a+=(${letters[i]})
    done
    echo 'yes'
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "b i r o s j v p") = "yes" ]]
}

run_test

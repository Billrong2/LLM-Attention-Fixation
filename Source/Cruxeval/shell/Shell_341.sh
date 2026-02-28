#!/bin/bash
# $1 is a $Dict
f() {
    while [ $(echo $1 | wc -w) -gt 5 ]; do
        key_to_remove=$(echo $1 | awk '{print $NF}')
        val_to_remove=$(echo $1 | awk -v key=$key_to_remove '{print $key}')
        eval "$1=( $(echo $1 | awk -v key=$key_to_remove '{for (i=1; i <=NF-2; i++) print $i}') )"
    done
    echo $1
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "") = "" ]]
}

run_test

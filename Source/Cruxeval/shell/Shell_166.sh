#!/bin/bash
# $1 is a two column CSV in key,value order
f() {
    while IFS=',' read -r key value; do
        new_graph["$key"]=""
    done < "$1"
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "") = "" ]]
}

run_test

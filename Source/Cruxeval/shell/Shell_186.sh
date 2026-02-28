#!/bin/bash
# $1 is a string
f() {
    echo $1 | awk '{$1=$1};1'
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "pvtso") = "pvtso" ]]
}

run_test

#!/bin/bash
# $1 is a string
f() {
    echo $1 | sed -e 's/(/[/g' -e 's/)/]/g'
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "(ac)") = "[ac]" ]]
}

run_test

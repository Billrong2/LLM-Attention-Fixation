#!/bin/bash
# $1 is a string
f() {
    echo $1 | sed 's/[^0-9]/ /g'
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "m4n2o") = " 4 2 " ]]
}

run_test

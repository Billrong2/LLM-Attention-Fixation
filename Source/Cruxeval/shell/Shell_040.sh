#!/bin/bash
# $1 is a string
f() {
    echo $1$(printf "%-1s" "#")
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "the cow goes moo") = "the cow goes moo#" ]]
}

run_test

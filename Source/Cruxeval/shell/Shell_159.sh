#!/bin/bash
# $1 is a string
f() {
    echo -n $1 | rev | tr '[:upper:][:lower:]' '[:lower:][:upper:]'
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "RTiGM") = "mgItr" ]]
}

run_test

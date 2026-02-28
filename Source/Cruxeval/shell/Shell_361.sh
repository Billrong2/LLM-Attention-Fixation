#!/bin/bash
# $1 is a string
f() {
    echo $1 | cut -d':' -f1 | tr -cd '#' | wc -c
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "#\! : #\!") = "1" ]]
}

run_test

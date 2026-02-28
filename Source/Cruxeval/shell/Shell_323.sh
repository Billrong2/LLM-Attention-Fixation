#!/bin/bash
# $1 is a string
f() {
    echo $1 | wc -l
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "ncdsdfdaaa0a1cdscsk*XFd") = "1" ]]
}

run_test

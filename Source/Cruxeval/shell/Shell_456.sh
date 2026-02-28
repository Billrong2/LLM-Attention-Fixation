#!/bin/bash
# $1 is a string
# $2 is an integer
f() {
    echo -e "$1" | expand -t $2
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "Join us in Hungary" "4") = "Join us in Hungary" ]]
}

run_test

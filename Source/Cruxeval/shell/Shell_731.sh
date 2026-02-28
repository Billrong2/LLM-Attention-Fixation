#!/bin/bash
# $1 is a string
# $2 is a string
f() {
    echo "${1//$2/}"
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "Chris requires a ride to the airport on Friday." "a") = "Chris requires  ride to the irport on Fridy." ]]
}

run_test

#!/bin/bash
# $1 is a string
f() {
    new_text=$(echo $1 | sed 's/[^0-9]/*/g')
    echo $new_text
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "5f83u23saa") = "5*83*23***" ]]
}

run_test

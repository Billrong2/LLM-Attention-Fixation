#!/bin/bash
# $1 is a string
f() {
    echo "${1: -1}${1:0:-1}"
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "hellomyfriendear") = "rhellomyfriendea" ]]
}

run_test

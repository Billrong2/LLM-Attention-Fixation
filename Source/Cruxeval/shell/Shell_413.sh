#!/bin/bash
# $1 is a string
f() {
    echo "${1:3:999}${1:2:1}${1:5:3}"
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "jbucwc") = "cwcuc" ]]
}

run_test

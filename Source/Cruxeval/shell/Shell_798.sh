#!/bin/bash
# $1 is a string
# $2 is a string
f() {
    if [[ ! $1 == $2* ]]; then
        echo $1
    else
        echo ${1#$2}
    fi
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "@hihu@\!" "@hihu") = "@\!" ]]
}

run_test

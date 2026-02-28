#!/bin/bash
# $1 is a string
# $2 is a string
f() {
    if [[ $1 == $2* ]]; then
        echo ${1#$2}
    else
        echo $1
    fi
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "fnuiyh" "ni") = "fnuiyh" ]]
}

run_test

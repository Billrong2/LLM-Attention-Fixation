#!/bin/bash
# $1 is a string
f() {
    if [[ $1 == *,* ]]; then
        before=${1%%,*}
        after=${1#*,}
        echo "$after $before"
    else
        echo ",${1##* } 0"
    fi
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "244, 105, -90") = " 105, -90 244" ]]
}

run_test

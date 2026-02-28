#!/bin/bash
# $1 is a space-separated list
f() {
    values=$1
    set -- $values
    for i in {1..3}; do
        set -- ${1} ${4} ${3} ${2} ${@:5}
    done
    echo $*
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "1 2 3") = "1 3 2" ]]
}

run_test

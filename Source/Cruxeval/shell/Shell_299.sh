#!/bin/bash
# $1 is a string
# $2 is a string
f() {
    if [[ $1 != *$2 ]]; then
        f "$2$1" $2
    else
        echo $1
    fi
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "staovk" "k") = "staovk" ]]
}

run_test

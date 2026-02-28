#!/bin/bash
# $1 is an integer
# $2 is a string
f() {
    if [ ${#2} -eq $1 ]; then
        echo $2 | rev
    else
        echo false
    fi
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "-5" "G5ogb6f,c7e.EMm") = "false" ]]
}

run_test

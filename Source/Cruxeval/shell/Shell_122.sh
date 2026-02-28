#!/bin/bash
# $1 is a string
f() {
    if [[ "${1:0:4}" != "Nuva" ]]; then
        echo "no"
    else
        echo $1 | xargs
    fi
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "Nuva?dlfuyjys") = "Nuva?dlfuyjys" ]]
}

run_test

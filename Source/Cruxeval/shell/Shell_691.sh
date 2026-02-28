#!/bin/bash
# $1 is a string
# $2 is a string
f() {
    if [ ! -z "$2" ] && [[ "$1" == *"${2: -1}"* ]]; then
        f "${1%${2: -1}}" "${2%?}"
    else
        echo "$1"
    fi
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "rpyttc" "cyt") = "rpytt" ]]
}

run_test

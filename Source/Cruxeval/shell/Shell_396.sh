#!/bin/bash
# $1 is a $Dict
f() {
    while [ ${#1} -ne 0 ]; do
        key="${!1}"
        value="${1[$key]}"
        unset $key
        eval $key=$(( $value * $value ))
    done
    echo $Dict
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "") = "" ]]
}

run_test

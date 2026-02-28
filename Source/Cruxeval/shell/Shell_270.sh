#!/bin/bash
# $1 is a $Dict
f() {
    declare -A d
    while [ ${#1[@]} -gt 0 ]; do
        key=$(echo "${!1}" | cut -d"=" -f1)
        value=$(echo "${1}" | cut -d"=" -f2)
        unset $1
        d[$key]=$value
    done
    declare -p d
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "") = "" ]]
}

run_test

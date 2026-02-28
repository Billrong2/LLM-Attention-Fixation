#!/bin/bash
# $1 is a space-separated list
f() {
    list=($1)
    if [ "${list[-1]}" = "${list[0]}" ]; then
        echo 'no'
    else
        list=("${list[@]:2}")
        list=("${list[@]:0:${#list[@]}-2}")
        echo "${list[@]}"
    fi
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "apple apple pear banana pear orange orange") = "pear banana pear" ]]
}

run_test

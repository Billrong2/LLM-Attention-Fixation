#!/bin/bash
# $1 is a string
# $2 is a string
# $3 is a string
f() {
    if [ ${#2} -gt 3 ]; then
        echo $1
    elif [[ $1 == *${2}* && $1 != *" "* ]]; then
        echo ${1//$2/$(printf "%0.s$3" $(seq 1 ${#2}))}
    else
        while [[ $1 == *${2}* ]]; do
            1=${1//$2/$3}
        done
        echo $1
    fi
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "avacado" "va" "-") = "a--cado" ]]
}

run_test

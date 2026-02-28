#!/bin/bash
# $1 is a string
# $2 is a string
f() {
    if [[ $1 == $2* ]]; then
        echo ${1#$2}
    elif [[ $1 == *$2* ]]; then
        echo ${1//$2}
    else
        echo $(echo $1 | tr '[:lower:]' '[:upper:]')
    fi
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "abixaaaily" "al") = "ABIXAAAILY" ]]
}

run_test

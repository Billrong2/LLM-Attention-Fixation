#!/bin/bash
# $1 is a string
# $2 is a string
# $3 is an integer
f() {
    index=$3
    old_char=${1:index:1}
    new_char=$2
    echo $(echo $1 | sed "s/$old_char/$new_char/g")
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "spain" "b" "4") = "spaib" ]]
}

run_test

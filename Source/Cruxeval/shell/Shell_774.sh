#!/bin/bash
# $1 is an integer
# $2 is a string
f() {
    f_str='quiz leader = %s, count = %d'
    printf "$f_str" "$2" $1
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "23" "Cornareti") = "quiz leader = Cornareti, count = 23" ]]
}

run_test

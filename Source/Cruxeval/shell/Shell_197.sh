#!/bin/bash
# $1 is an integer
# $2 is an integer
f() {
    s=$(( $2 / $1 ))
    e=$(( $2 % $1 ))
    if [ $s -gt 1 ]; then
        echo "$s $e"
    else
        echo "$e oC"
    fi
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "1" "1234567890") = "1234567890 0" ]]
}

run_test

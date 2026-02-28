#!/bin/bash
# $1 is a string
# $2 is a string
f() {
    left=$(echo $1 | awk -F"$2" '{print $1}')
    right=$(echo $1 | awk -F"$2" '{print $2}')
    echo $right$left
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "difkj rinpx" "k") = "j rinpxdif" ]]
}

run_test

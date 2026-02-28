#!/bin/bash
# $1 is a string
f() {
    if [[ $1 =~ ^[0-9]+$ ]]; then
        total=$(( $1 * 4 - 50 ))
        count=$(echo $1 | grep -o [13579] | wc -l)
        total=$(( $total - $count * 100 ))
        echo $total
    else
        echo 'NAN'
    fi
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "0") = "-50" ]]
}

run_test

#!/bin/bash
# $1 is a string
# $2 is a string
# $3 is an integer
f() {
    python -c "print('___'.join('$1'.rsplit('$2', $3)))"
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "aa+++bb" "+" "1") = "aa++___bb" ]]
}

run_test

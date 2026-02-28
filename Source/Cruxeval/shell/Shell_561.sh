#!/bin/bash
# $1 is a string
# $2 is a string
f() {
    count=$(echo $1 | grep -o $2 | wc -l)
    echo $(( $2 * count ))
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "7Ljnw4Lj" "7") = "7" ]]
}

run_test

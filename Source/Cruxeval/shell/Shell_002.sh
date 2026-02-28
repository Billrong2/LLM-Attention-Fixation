#!/bin/bash
# $1 is a string
f() {
    new_text=$(echo $1 | sed 's/+//g')
    echo $new_text
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "hbtofdeiequ") = "hbtofdeiequ" ]]
}

run_test

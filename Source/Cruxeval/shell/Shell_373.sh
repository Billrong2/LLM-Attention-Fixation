#!/bin/bash
# $1 is a $List
f() {
    copy=("$@")
    copy=("${copy[@]}" "100")
    unset 'copy[${#copy[@]}-1]'
    echo "${copy[@]}"
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "1 2 3") = "1 2 3" ]]
}

run_test

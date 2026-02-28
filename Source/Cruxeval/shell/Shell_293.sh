#!/bin/bash
# $1 is a string
f() {
    s=$(echo $1 | tr '[:upper:]' '[:lower:]')
    if echo $s | grep -q 'x'; then
        echo "no"
    else
        [[ $1 =~ [A-Z] ]] && echo "1" || echo "0"
    fi
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "dEXE") = "no" ]]
}

run_test

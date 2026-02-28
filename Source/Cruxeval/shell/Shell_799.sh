#!/bin/bash
# $1 is a string
f() {
    if [ "${1:0:1}" = "~" ]; then
        e=$(printf '%-10s' "s${1:1}")
        echo $(f "${e// /s}")
    else
        echo $(printf '%-10s' "n$1")
    fi
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "eqe-;ew22") = "neqe-;ew22" ]]
}

run_test

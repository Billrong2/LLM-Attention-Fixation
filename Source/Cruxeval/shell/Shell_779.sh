#!/bin/bash
# $1 is a string
f() {
    IFS=' ' read -r -a values <<< "$1"
    printf '${first}y, ${second}x, ${third}r, ${fourth}p'
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "python ruby c javascript") = "\${first}y, \${second}x, \${third}r, \${fourth}p" ]]
}

run_test

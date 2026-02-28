#!/bin/bash
# $1 is a string
f() {
    case $1 in
        *[^[:ascii:]]*) echo "false";;
        *) echo "true";;
    esac
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "wW의IV]HDJjhgK[dGIUlVO@Ess\$coZkBqu[Ct") = "false" ]]
}

run_test

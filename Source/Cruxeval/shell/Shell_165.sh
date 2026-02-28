#!/bin/bash
# $1 is a string
# $2 is an integer
# $3 is an integer
f() {
    substring=$(echo $1 | cut -c $(($2+1))-$(( $3 )))
    echo $substring | grep -q '[ -~]' && echo "true" || echo "false"
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "=xtanp|sugv?z" "3" "6") = "true" ]]
}

run_test

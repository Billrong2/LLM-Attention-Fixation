#!/bin/bash
# $1 is an integer
f() {
    n=$1
    streak=""
    for (( i=0; i<${#n}; i++ )); do
        c=${n:$i:1}
        streak+=$(printf '%-*s' "$((c * 2))" "$c")
    done
    echo "$streak"
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "1") = "1 " ]]
}

run_test

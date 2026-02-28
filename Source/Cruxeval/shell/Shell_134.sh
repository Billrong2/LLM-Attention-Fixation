#!/bin/bash
# $1 is an integer
f() {
    t=0
    b=''
    digits=($(echo $1 | fold -w1))
    for d in "${digits[@]}"; do
        if [ "$d" -eq 0 ]; then
            ((t++))
        else
            break
        fi
    done
    for ((i=0; i<t; i++)); do
        b+=1104
    done
    b+=${1}
    echo $b
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "372359") = "372359" ]]
}

run_test

#!/bin/bash
# $1 is a string
f() {
    num=$1
    letter=1
    for i in {1..9}; do
        num=$(echo $num | tr -d $i)
        if [ -z $num ]; then
            break
        fi
        num=$(echo $num | cut -c$(($letter+1))-${#num})$(echo $num | cut -c1-$letter)
        ((letter++))
    done
    echo $num
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "bwmm7h") = "mhbwm" ]]
}

run_test

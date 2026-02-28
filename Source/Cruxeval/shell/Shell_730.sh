#!/bin/bash
# $1 is a string
f() {
    m=0
    cnt=0
    for i in $1; do
        len=${#i}
        if [ $len -gt $m ]; then
            cnt=$(( $cnt + 1 ))
            m=$len
        fi
    done
    echo $cnt
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "wys silak v5 e4fi rotbi fwj 78 wigf t8s lcl") = "2" ]]
}

run_test

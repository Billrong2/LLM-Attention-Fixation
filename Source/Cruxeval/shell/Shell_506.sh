#!/bin/bash
# $1 is an integer
f() {
    p=''
    if [ $(( $1 % 2 )) -eq 1 ]; then
        p+='sn'
    else
        echo $(( $1 * $1 ))
        return
    fi

    for (( x=1; x<=$1; x++ )); do
        if [ $(( $x % 2 )) -eq 0 ]; then
            p+='to'
        else
            p+='ts'
        fi
    done

    echo $p
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "1") = "snts" ]]
}

run_test

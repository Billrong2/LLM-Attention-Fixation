#!/bin/bash
# $1 is a string
# $2 is a string
f() {
    length=${#2}
    if [ $length -le ${#1} ]; then
        for ((i=0; i<$length; i++)); do
            if [ "${2:$length-$i-1:1}" != "${1:${#1}-$i-1:1}" ]; then
                echo $i
                return
            fi
        done
    fi
    echo $length
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "managed" "") = "0" ]]
}

run_test

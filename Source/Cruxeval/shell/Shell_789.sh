#!/bin/bash
# $1 is a string
# $2 is an integer
f() {
    if [[ $2 -lt 0 || ${#1} -le $2 ]]; then
        echo $1
    else
        result=${1:0:$2}
        i=$(( ${#result} - 1 ))
        while [[ $i -ge 0 ]]; do
            if [[ ${result:$i:1} != ${1:$i:1} ]]; then
                break
            fi
            i=$(( i - 1 ))
        done
        echo ${1:0:$(( i + 1 ))}
    fi
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "bR" "-1") = "bR" ]]
}

run_test

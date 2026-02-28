#!/bin/bash
# $1 is a string
f() {
    count=0
    a=""
    for ((i=0;i<${#1};i++)); do
        count=$(( count + 1 ))
        if [ $(( count % 2 )) -eq 0 ]; then
            a+=`echo "${1:i:1}" | tr '[:upper:][:lower:]' '[:lower:][:upper:]'`
        else
            a+=${1:i:1}
        fi
    done
    echo $a
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "987yhNSHAshd 93275yrgSgbgSshfbsfB") = "987YhnShAShD 93275yRgsgBgssHfBsFB" ]]
}

run_test

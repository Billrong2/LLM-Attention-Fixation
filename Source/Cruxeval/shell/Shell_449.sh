#!/bin/bash
# $1 is a string
f() {
    str=$1
    n=${#str}
    i=0
    while [ $i -lt $n ] && [[ ${str:$i:1} =~ ^[0-9]+$ ]]
    do
        ((i+=1))
    done
    if [ $i -eq $n ]
    then
        echo "true"
    else
        echo "false"
    fi
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "1") = "true" ]]
}

run_test

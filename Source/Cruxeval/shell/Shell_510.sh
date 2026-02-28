#!/bin/bash
# $1 is a two column CSV in key,value order
# $2 is an integer
# $3 is a string
# $4 is a string
# $5 is an argument
f() {
    key=$4
    if [[ $1 == *"$key"* ]]; then
        num=$(echo "$1" | grep "$key" | cut -d',' -f2)
    fi

    if [ $2 -gt 3 ]; then
        echo $3
    else
        echo $num
    fi
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "7,ii5p
1,o3Jwus
3,lot9L
2,04g
9,Wjf
8,5b
0,te6
5,flLO
6,jq
4,vfa0tW" "4" "Wy" "Wy" "1.0") = "Wy" ]]
}

run_test

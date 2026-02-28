#!/bin/bash
# $1 is a two column CSV in key,value order
# $2 is an integer
f() {
    length=$(echo $1 | awk -F',' '{print NF}')
    idx=$(( $2 % $length ))
    v=$(echo $1 | awk -F',' '{print $2}')
    
    for i in $(seq 1 $idx); do
        v=$(echo $1 | awk -F',' '{print $2}')
        sed -i '$ d' <<< "$1"
    done
    
    echo $v
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "27,39" "1") = "39" ]]
}

run_test

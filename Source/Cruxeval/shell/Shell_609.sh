#!/bin/bash
# $1 is a two column CSV in key,value order
# $2 is a $Any
f() {
    local array=($1)
    local elem=$2
    local result=()

    for i in "${!array[@]}"; do
        key=${array[$i]}
        value=${array[$(($i+1))]}
        
        if [[ $elem == $key || $elem == $value ]]; then
            result+=($1)
        fi
        i=$(($i+1))
    done

    echo "${result[@]}"
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "" "1") = "" ]]
}

run_test

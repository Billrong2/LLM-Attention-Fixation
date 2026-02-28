#!/bin/bash
# $1 is a space-separated list
f() {
    array=($1)
    prev=${array[0]}
    newArray=($1)
    for ((i=1; i<${#array[@]}; i++)); do
        if [ $prev -ne ${array[i]} ]; then
            newArray[i]=${array[i]}
        else
            unset 'newArray[i]'
        fi
        prev=${array[i]}
    done
    echo "${newArray[@]}"
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "1 2 3") = "1 2 3" ]]
}

run_test

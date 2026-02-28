#!/bin/bash
# $1 is a space-separated list
f() {
    arr=($1)
    n=()
    for item in ${arr[@]}; do
        if [ $(( $item % 2 )) -eq 0 ]; then
            n+=($item)
        fi
    done
    
    m=(${n[@]} ${arr[@]})
    for i in ${m[@]}; do
        index=$(echo ${m[@]} | tr -s ' ' '\n' | grep -nx $i | cut -d : -f 1)
        if [ $index -ge ${#n[@]} ]; then
            m=(${m[@]/$i})
        fi
    done
    
    echo ${m[@]}
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "3 6 4 -2 5") = "6 4 -2 6 4 -2" ]]
}

run_test

#!/bin/bash
# $1 is a space-separated list
f() {
    lst=($1)
    i=0
    new_list=()
    while [ $i -lt ${#lst[@]} ]; do
        if [[ " ${lst[@]:$(($i+1))} " =~ " ${lst[$i]} " ]]; then
            new_list+=(${lst[$i]})
            if [ ${#new_list[@]} -eq 3 ]; then
                echo ${new_list[@]}
                return
            fi
        fi
        ((i++))
    done
    echo ${new_list[@]}
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "0 2 1 2 6 2 6 3 0") = "0 2 2" ]]
}

run_test

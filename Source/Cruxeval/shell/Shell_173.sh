#!/bin/bash
# $1 is a space-separated list
f() {
    local list_x=($1)
    local item_count=${#list_x[@]}
    local new_list=()
    
    for ((i=$item_count-1; i>=0; i--)); do
        new_list+=(${list_x[i]})
    done
    
    echo "${new_list[@]}"
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "5 8 6 8 4") = "4 8 6 8 5" ]]
}

run_test

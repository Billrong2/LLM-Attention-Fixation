#!/bin/bash
# $1 is a space-separated list
# $2 is a space-separated list
f() {
    local list1=($1)
    local list2=($2)
    local l=("${list1[@]}")
    
    while [ ${#l[@]} -gt 0 ]; do
        if [[ " ${list2[@]} " =~ " ${l[-1]} " ]]; then
            l=("${l[@]::${#l[@]}-1}")
        else
            echo "${l[-1]}"
            return
        fi
    done
    
    echo "missing"
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "0 4 5 6" "13 23 -5 0") = "6" ]]
}

run_test

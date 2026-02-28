#!/bin/bash
# $1 is a space-separated list
f() {
    list=($1)
    if [ ${#list[@]} -eq 0 ]; then
        echo "-1"
    else
        declare -A cache
        for item in "${list[@]}"; do
            if [ -n "${cache[$item]}" ]; then
                ((cache[$item]++))
            else
                cache[$item]=1
            fi
        done
        
        max=0
        for val in "${!cache[@]}"; do
            if [ ${cache[$val]} -gt $max ]; then
                max=${cache[$val]}
            fi
        done
        
        echo $max
    fi
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "1 0 2 2 0 0 0 1") = "4" ]]
}

run_test

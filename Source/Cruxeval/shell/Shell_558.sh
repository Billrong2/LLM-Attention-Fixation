#!/bin/bash
# $1 is a space-separated list
# $2 is a space-separated list
f() {
    local nums=($1)
    local mos=($2)
    
    for num in "${mos[@]}"
    do
        for (( i=0; i<"${#nums[@]}"; i++ ))
        do
            if [ "${nums[i]}" = "$num" ]; then
                unset 'nums[i]'
                break
            fi
        done
    done
    
    nums=($(echo "${nums[@]}" | tr ' ' '\n' | sort -n))
    
    for num in "${mos[@]}"
    do
        nums+=("$num")
    done
    
    for (( i=0; i<"${#nums[@]}-1"; i++ ))
    do
        if [ "${nums[i]}" -gt "${nums[i+1]}" ]; then
            echo "false"
            return
        fi
    done
    
    echo "true"
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "3 1 2 1 4 1" "1") = "false" ]]
}

run_test

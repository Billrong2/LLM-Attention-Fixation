#!/bin/bash
# $1 is a space-separated list
# $2 is a space-separated list
f() {
    local array=($1)
    local lst=($2)
    
    for e in ${lst[@]}; do
        array+=($e)
    done
    
    for e in ${array[@]}; do
        if (( $e % 2 == 0 )); then
            even_array+=($e)
        fi
    done
    
    for e in ${array[@]}; do
        if (( $e >= 10 )); then
            result+=($e)
        fi
    done
    
    echo "${result[@]}"
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "2 15" "15 1") = "15 15" ]]
}

run_test

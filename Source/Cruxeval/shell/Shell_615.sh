#!/bin/bash
# $1 is a space-separated list
# $2 is an integer
f() {
    list=($1)
    list+=($2)
    max_idx=0
    max_val=0
    
    for ((i=0;i<${#list[@]}-1;i++))
    do
        if [ ${list[$i]} -gt $max_val ]
        then
            max_val=${list[$i]}
            max_idx=$i
        fi
    done
    
    echo $max_idx
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "-1 12 -6 -2" "-1") = "1" ]]
}

run_test

#!/bin/bash
# $1 is a space-separated list
# $2 is an integer
# $3 is an integer
f() {
    local array=($1)
    local ind=$2
    local elem=$3
    local new_array=()

    if [ $ind -lt 0 ]; then
        ind=-5
    elif [ $ind -gt ${#array[@]} ]; then
        ind=${#array[@]}
    else
        ((ind++))
    fi

    for ((i=0; i<${#array[@]}; i++)); do
        if [ $i -eq $ind ]; then
            new_array+=($elem)
        fi
        new_array+=(${array[i]})
    done

    echo "${new_array[*]}"
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "1 5 8 2 0 3" "2" "7") = "1 5 8 7 2 0 3" ]]
}

run_test

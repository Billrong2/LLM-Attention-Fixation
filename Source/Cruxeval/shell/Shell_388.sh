#!/bin/bash
# $1 is a string
# $2 is a string
f() {
    characters=($(echo $2 | grep -o .))
    character_list=("${characters[@]}" " " "_")

    i=0
    while [ $i -lt ${#1} ] && [[ " ${character_list[@]} " =~ " ${1:i:1} " ]]; do
        ((i++))
    done

    echo ${1:i}
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "2nm_28in" "nm") = "2nm_28in" ]]
}

run_test

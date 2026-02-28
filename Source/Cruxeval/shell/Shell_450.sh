#!/bin/bash
# $1 is a string
f() {
    local strs=($1)
    local output=""
    for ((i=0; i<${#strs[@]}; i++)); do
        if ((i % 2 != 0)); then
            output+=" $(echo ${strs[i]} | rev)"
        else
            output+=" ${strs[i]}"
        fi
    done
    echo $output
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "K zBK") = "K KBz" ]]
}

run_test

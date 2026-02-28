#!/bin/bash
# $1 is a string
# $2 is an integer
f() {
    local text=$1
    local tab_size=$2
    local res=''

    text=$(echo "$text" | sed "s/\t/$(printf '%0.s ' $(seq 1 $((tab_size-1))))/g")

    for ((i=0; i<${#text}; i++)); do
        if [ "${text:$i:1}" = ' ' ]; then
            res+='|'
        else
            res+=${text:$i:1}
        fi
    done

    echo $res
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "	a" "3") = "||a" ]]
}

run_test

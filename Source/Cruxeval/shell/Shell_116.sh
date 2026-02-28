#!/bin/bash
# $1 is a $Dict
# $2 is an integer
f() {
    local -n dict=$1
    for ((i=0; i<$2; i++)); do
        if [ -z "$dict" ]; then
            break
        fi
        unset 'dict[${!dict[@]: -1}]'
    done
    echo "${dict[@]}"
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "" "200") = "" ]]
}

run_test

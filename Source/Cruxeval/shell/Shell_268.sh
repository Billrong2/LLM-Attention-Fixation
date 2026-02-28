#!/bin/bash
# $1 is a string
# $2 is a string
f() {
    local s=$1
    local separator=$2
    local new_s=""
    local replaced=0

    for (( i=0; i<${#s}; i++ )); do
        if [[ ${s:$i:1} == "$separator" && $replaced -eq 0 ]]; then
            new_s+="/"
            replaced=1
        else
            new_s+=${s:$i:1}
        fi
    done

    # Add spaces between each character
    local result=""
    for (( i=0; i<${#new_s}; i++ )); do
        result+="${new_s:$i:1} "
    done

    # Trim the trailing space
    echo "${result% }"
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "h grateful k" " ") = "h / g r a t e f u l   k" ]]
}

run_test

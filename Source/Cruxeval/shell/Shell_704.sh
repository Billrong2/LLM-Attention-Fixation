#!/bin/bash
# $1 is a string
# $2 is an integer
# $3 is a string
f() {
    local s=$1
    local n=$2
    local c=$3
    local width=$((${#c} * $n))
    local len_s=${#s}
    
    for ((i = 0; i < $width - $len_s; i++)); do
        s=$c$s
    done
    
    echo $s
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "." "0" "99") = "." ]]
}

run_test

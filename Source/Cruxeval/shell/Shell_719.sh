#!/bin/bash
# $1 is a string
f() {
    local code=$1
    local IFS=$']'
    read -ra lines <<< "$code"
    declare -a result
    local level=0
    
    for line in "${lines[@]}"; do
        result+=("${line:0:1} $(printf "%${level}s")${line:1}")
        level=$(( $level + $(grep -o '{' <<< "$line" | wc -l) - $(grep -o '}' <<< "$line" | wc -l) ))
    done
    
    echo "${result[@]}"
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "if (x) {y = 1;} else {z = 1;}") = "i f (x) {y = 1;} else {z = 1;}" ]]
}

run_test

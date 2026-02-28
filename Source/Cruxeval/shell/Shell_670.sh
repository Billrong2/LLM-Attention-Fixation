#!/bin/bash
# $1 is a space-separated list
# $2 is a space-separated list
f() {
    declare -A d
    a=($1)
    b=($2)
    
    for ((i=0; i<${#a[@]}; i++)); do
        d[${a[$i]}]=${b[$i]}
    done

    IFS=$'\n' sorted=($(sort -nrk2 <(for i in ${a[@]}; do echo $i ${d[$i]}; done)))
    unset IFS
    
    result=()
    for pair in ${sorted[@]}; do
        key=${pair% *}
        result+=(${d[$key]})
        unset d[$key]
    done
    
    echo "${result[@]}"
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "12 ab" "2 2") = "2 2" ]]
}

run_test

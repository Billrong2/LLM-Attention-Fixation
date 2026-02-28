#!/bin/bash
# $1 is a string
# $2 is a string
# $3 is an integer
f() {
    text="$1"
    sep="$2"
    maxsplit="$3"
    
    IFS=$sep read -ra splitted <<< "$text"
    length=${#splitted[@]}
    
    new_splitted=("${splitted[@]:0:length / 2}")
    new_splitted=($(echo "${new_splitted[@]}" | tac))
    new_splitted+=("${splitted[@]:length / 2}")
    
    new_text=$(IFS=$sep; echo "${new_splitted[*]}")
    echo $new_text
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "ertubwi" "p" "5") = "ertubwi" ]]
}

run_test

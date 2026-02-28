#!/bin/bash
# $1 is a string
f() {
    text_list=($(echo $1 | grep -o .))
    for ((i=0; i<${#text_list[@]}; i++)); do
        text_list[i]=$(tr '[:upper:][:lower:]' '[:lower:][:upper:]' <<< "${text_list[i]}")
    done
    echo ${text_list[@]} | tr -d ' '
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "akA?riu") = "AKa?RIU" ]]
}

run_test

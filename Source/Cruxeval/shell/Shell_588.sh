#!/bin/bash
# $1 is a space-separated list
# $2 is a string
f() {
    IFS=' ' read -ra arr <<< "$1"
    for i in "${!arr[@]}"; do
       if [[ "${arr[$i]}" = "$2" ]]; then
           echo $i
           return
       fi
    done
    echo -1
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "1 + - ** // * +" "**") = "3" ]]
}

run_test

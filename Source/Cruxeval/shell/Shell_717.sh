#!/bin/bash
# $1 is a string
f() {
    text=$1
    k=0
    l=$(expr length "$text" - 1)
    
    while [[ ! "${text:l:1}" =~ [a-zA-Z] ]]; do
        l=$(expr $l - 1)
    done
    
    while [[ ! "${text:k:1}"  =~ [a-zA-Z] ]]; do
        k=$(expr $k + 1)
    done
    
    if [[ $k != 0 || $l != $(expr length "$text" - 1) ]]; then
        echo ${text:$k:$(expr $l - $k + 1)}
    else
        echo ${text:0:1}
    fi
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "timetable, 2mil") = "t" ]]
}

run_test

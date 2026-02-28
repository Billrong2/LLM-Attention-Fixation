#!/bin/bash
# $1 is a string
# $2 is a string
f() {
    local text=$1
    local dng=$2
    
    if [[ $text != *"$dng"* ]]; then
        echo $text
        return
    fi
    
    if [[ ${text: -${#dng}} == "$dng" ]]; then
        echo ${text:0: -${#dng}}
        return
    fi
    
    echo ${text:0: -1}$(f "${text:0: -2}" "$dng")
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "catNG" "NG") = "cat" ]]
}

run_test

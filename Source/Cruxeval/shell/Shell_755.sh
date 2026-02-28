#!/bin/bash
# $1 is a string
# $2 is a string
# $3 is a string
f() {
    local replace=$1
    local text=$2
    local hide=$3
    
    while [[ $text == *$hide* ]]; do
        replace+="ax"
        text="${text/$hide/$replace}"
    done

    echo $text
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "###" "ph>t#A#BiEcDefW#ON#iiNCU" ".") = "ph>t#A#BiEcDefW#ON#iiNCU" ]]
}

run_test

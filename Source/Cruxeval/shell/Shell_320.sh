#!/bin/bash
# $1 is a string
f() {
    text=$1
    index=1
    while [ $index -lt ${#text} ]; do
        if [ "${text:index:1}" != "${text:index-1:1}" ]; then
            index=$((index+1))
        else
            text1=${text:0:index}
            text2=$(echo "${text:index}" | tr '[:upper:][:lower:]' '[:lower:][:upper:]')
            echo "${text1}${text2}"
            return
        fi
    done
    echo "${text}" | tr '[:upper:][:lower:]' '[:lower:][:upper:]'
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "USaR") = "usAr" ]]
}

run_test

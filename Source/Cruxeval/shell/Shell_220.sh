#!/bin/bash
# $1 is a string
# $2 is an integer
# $3 is an integer
f() {
    text=$1
    m=$2
    n=$3
    text="${text}${text:0:m}${text:n}"
    result=""
    for ((i=n; i<${#text}-m; i++)); do
        result="${text:i:1}${result}"
    done
    echo $result
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "abcdefgabc" "1" "2") = "bagfedcacbagfedc" ]]
}

run_test

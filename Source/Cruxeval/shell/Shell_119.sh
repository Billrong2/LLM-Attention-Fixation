#!/bin/bash
# $1 is a string
f() {
    result=""
    text=$1
    for ((i=0; i<${#text}; i++)); do
        if [ $((i % 2)) -eq 0 ]; then
            result+=$(echo ${text:$i:1} | tr '[:upper:][:lower:]' '[:lower:][:upper:]')
        else
            result+=${text:$i:1}
        fi
    done
    echo $result
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "vsnlygltaw") = "VsNlYgLtAw" ]]
}

run_test

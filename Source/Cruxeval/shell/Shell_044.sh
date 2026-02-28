#!/bin/bash
# $1 is a string
f() {
    text=$1
    new_text=""
    for (( i=0; i<${#text}; i++ )); do
        if [ "${text:$i:1}" != "+" ]; then
            new_text+="*+"
            break
        fi
    done
    new_text+=${text}
    echo $new_text | sed 's/./&+/g' | sed 's/+*$//'
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "nzoh") = "*+++n+z+o+h" ]]
}

run_test

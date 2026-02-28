#!/bin/bash
# $1 is a string
# $2 is a string
f() {
    text=$1
    char=$2
    length=${#text}
    index=-1
    for (( i=0; i<${length}; i++ )); do
        if [[ "${text:$i:1}" == "$char" ]]; then
            index=$i
            break
        fi
    done
    if [[ $index -eq -1 ]]; then
        index=$(( length / 2 ))
    fi
    new_text=${text:0:$index}${text:$((index+1))}
    echo $new_text
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "o horseto" "r") = "o hoseto" ]]
}

run_test

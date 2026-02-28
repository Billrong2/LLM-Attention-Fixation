#!/bin/bash

f() {
    text=$1
    last_o_index=0
    for (( i=0; i<${#text}; i++ )); do
        if [ "${text:$i:1}" = "o" ]; then
            last_o_index=$i
        fi
    done

    if [ $last_o_index -eq 0 ]; then
        echo "-$text"
    else
        echo "${text:0:$last_o_index}o${text:$last_o_index}"
    fi
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "kkxkxxfck") = "-kkxkxxfck" ]]
}

run_test

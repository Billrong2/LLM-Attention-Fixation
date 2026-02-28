#!/bin/bash
# $1 is a string
f() {
    text=$1
    reversed_text=$(echo $text | rev)
    result=""
    
    for (( i=0; i<${#text}; i++ )); do
        letter=${text:$i:1}
        if [[ $letter =~ [a-z] ]]; then
            if [[ $letter =~ [a-y] ]]; then
                result="${result}${letter}"
            fi
        else
            result="${result}${letter}"
        fi
    done
    
    echo $result
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "qq") = "qq" ]]
}

run_test

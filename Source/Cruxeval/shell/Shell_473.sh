#!/bin/bash
# $1 is a string
# $2 is a string
f() {
    text=$1
    value=$2
    indexes=()
    for (( i=0; i<${#text}; i++ )); do
        if [ "${text:$i:1}" = "$value" ]; then
            indexes+=($i)
        fi
    done
    
    new_text=($(echo $text | sed "s/$value//g"))
    
    echo ${new_text[@]}
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "scedvtvotkwqfoqn" "o") = "scedvtvtkwqfqn" ]]
}

run_test

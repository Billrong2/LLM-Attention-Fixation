#!/bin/bash
# $1 is a string
f() {
    local input_string=$1
    local table=$(echo "aioe" | tr 'aioe' 'ioua')
    
    while echo "$input_string" | grep -q '[aA]'; do
        input_string=$(echo "$input_string" | tr 'aioe' 'ioua')
    done
    
    echo $input_string
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "biec") = "biec" ]]
}

run_test

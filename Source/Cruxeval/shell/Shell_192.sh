#!/bin/bash
# $1 is a string
# $2 is a string
f() {
    output=$1
    while [[ $output == *$2 ]]; do
        output=${output:0:$((${#output}-${#2}))}
    done
    echo $output
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "\!klcd\!ma:ri" "\!") = "\!klcd\!ma:ri" ]]
}

run_test

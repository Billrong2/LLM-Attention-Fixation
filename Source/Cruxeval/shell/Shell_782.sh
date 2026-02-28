#!/bin/bash
# $1 is a string
f() {
    input=$1
    for (( i=0; i<${#input}; i++ )); do
        char=${input:i:1}
        if [[ $char =~ [A-Z] ]]; then
            echo "false"
            return
        fi
    done
    echo "true"
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "a j c n x X k") = "false" ]]
}

run_test

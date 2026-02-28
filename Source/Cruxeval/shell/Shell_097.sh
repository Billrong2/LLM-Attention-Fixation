#!/bin/bash
# $1 is a space-separated list
f() {
    lst=($1)
    unset 'lst[-1]'
    
    for i in "${lst[@]}"; do
        if [ $i -eq 3 ]; then
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
    [[ $(candidate "2 0") = "true" ]]
}

run_test

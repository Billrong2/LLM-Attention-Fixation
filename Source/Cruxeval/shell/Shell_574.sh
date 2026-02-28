#!/bin/bash
# $1 is a space-separated list
f() {
    IFS=' ' read -ra simpons <<< "$1"
    while [ ${#simpons[@]} -gt 0 ]; do
        pop=${simpons[-1]}
        if [ "$pop" == "$(echo $pop | sed 's/.*/\u&/')" ]; then
            echo $pop
            return
        fi
        simpons=("${simpons[@]::${#simpons[@]}-1}")
    done
    echo $pop
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "George Michael George Costanza") = "Costanza" ]]
}

run_test

#!/bin/bash
# $1 is a space-separated list
f() {
    local array=($1)
    local result=()
    for element in "${array[@]}"; do
        if [ $element -ge 0 ]; then
            result+=("$element")
        fi
    done
    echo "${result[@]}"
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "") = "" ]]
}

run_test

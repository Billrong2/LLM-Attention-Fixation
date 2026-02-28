#!/bin/bash
# $1 is an integer
f() {
    transl=("A=1" "B=2" "C=3" "D=4" "E=5")
    result=()
    for entry in "${transl[@]}"; do
        key=$(echo $entry | cut -d'=' -f1)
        value=$(echo $entry | cut -d'=' -f2)
        if [ $((value % $1)) -eq 0 ]; then
            result+=($key)
        fi
    done
    echo "${result[@]}"
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "2") = "B D" ]]
}

run_test

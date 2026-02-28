#!/bin/bash
# $1 is a space-separated list
# $2 is a string
f() {
    total=("$1")
    arg="$2"
    if [[ $arg == *" "* ]]; then
        OLD_IFS=$IFS
        IFS=' '
        read -ra arg_array <<< "$arg"
        IFS=$OLD_IFS
        total+=("${arg_array[@]}")
    else
        for (( i=0; i<${#arg}; i++ )); do
            total+=("${arg:$i:1}")
        done
    fi
    echo "${total[@]}"
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "1 2 3" "nammo") = "1 2 3 n a m m o" ]]
}

run_test

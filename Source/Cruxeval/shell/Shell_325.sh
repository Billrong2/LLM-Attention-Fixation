#!/bin/bash
# $1 is a string
f() {
    local l=$(echo $1 | grep -o .)
    for i in $(seq 0 $((${#l} - 1))); do
        l_i=$(echo $l | cut -c $(($i + 1)) )
        l_i=$(echo $l_i | tr '[:upper:]' '[:lower:]')
        if ! [[ $l_i =~ ^[0-9]$ ]]; then
            echo "false"
            return 1
        fi
    done
    echo "true"
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "") = "true" ]]
}

run_test

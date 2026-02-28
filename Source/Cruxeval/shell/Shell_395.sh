#!/bin/bash
# $1 is a string
f() {
    str=$1
    for (( i=0; i<${#str}; i++ )); do
        if [[ ${str:i:1} =~ [0-9] ]]; then
            if [ ${str:i:1} -eq 0 ]; then
                echo $((i + 1))
                return
            else
                echo $((i))
                return
            fi
        elif [ ${str:i:1} == 0 ]; then
            echo -1
            return
        fi
    done
    echo -1
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "11") = "0" ]]
}

run_test

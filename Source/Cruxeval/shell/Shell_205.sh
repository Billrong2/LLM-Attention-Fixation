#!/bin/bash
# $1 is a string
f() {
    local a=$1
    for i in {1..10}; do
        for (( j=0; j<${#a}; j++ )); do
            if [ "${a:$j:1}" != "#" ]; then
                a=${a:$j}
                break
            fi
            if [ $j -eq $((${#a} - 1)) ]; then
                a=""
                break
            fi
        done
    done

    while [[ "${a: -1}" == "#" ]]; do
        a=${a::-1}
    done

    echo $a
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "##fiu##nk#he###wumun##") = "fiu##nk#he###wumun" ]]
}

run_test

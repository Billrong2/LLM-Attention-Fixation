#!/bin/bash
# $1 is a string
f() {
    short=''
    for (( i=0; i<${#1}; i++ )); do
        c="${1:$i:1}"
        if [[ $c =~ [a-z] ]]; then
            short="${short}${c}"
        fi
    done
    echo $short
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "980jio80jic kld094398IIl ") = "jiojickldl" ]]
}

run_test

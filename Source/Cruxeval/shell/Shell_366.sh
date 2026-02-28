#!/bin/bash
# $1 is a string
f() {
    tmp=$(echo $1 | tr '[:upper:]' '[:lower:]')
    for ((i=0; i<${#tmp}; i++)); do
        char=${tmp:i:1}
        if [[ $tmp == *"$char"* ]]; then
            tmp=$(echo $tmp | sed "s/$char//" -n -e 1p)
        fi
    done
    echo $tmp
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "[ Hello ]+ Hello, World\!\!_ Hi") = "" ]]
}

run_test

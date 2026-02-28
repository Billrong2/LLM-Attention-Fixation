#!/bin/bash
# $1 is a string
# $2 is a string
f() {
    subject="${1##*$2}"
    count=$(grep -o $2 <<< $1 | wc -l)
    for ((i=0; i<$count; i++)); do
        echo -n $subject
    done
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "h ,lpvvkohh,u" "i") = "" ]]
}

run_test

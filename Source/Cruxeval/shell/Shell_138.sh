#!/bin/bash
# $1 is a string
# $2 is a string
f() {
    text=$1
    chars=$2
    listchars=($(echo $chars | grep -o .))
    first=${listchars[-1]}
    for i in "${listchars[@]:0:${#listchars[@]}-1}"; do
        text=$(echo $text | sed "s/./$i/${!text}/1")
    done
    echo $text
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "tflb omn rtt" "m") = "tflb omn rtt" ]]
}

run_test

#!/bin/bash
# $1 is a string
f() {
    text=$1
    uppercase_index=$(echo $text | awk '{print index($0,"A")}')
    if [ $uppercase_index -gt 0 ]; then
        lowercase_index=$(echo $text | awk '{print index($0,"a")}')
        echo ${text:0: $((uppercase_index - 1))} ${text: $lowercase_index}
    else
        echo $text | grep -o . | sort | tr -d "\n"
    fi
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "E jIkx HtDpV G") = "   DEGHIVjkptx" ]]
}

run_test

#!/bin/bash
# $1 is a string
f() {
    text=${1// x/ x.}
    if [[ $(tr '[:lower:]' '[:upper:]' <<< "${text:0:1}") == "${text:0:1}" ]]; then
        echo "correct"
    else
        echo "mixed"
    fi
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "398 Is A Poor Year To Sow") = "correct" ]]
}

run_test

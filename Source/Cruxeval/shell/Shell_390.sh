#!/bin/bash
# $1 is a string
f() {
    stripped=$(echo $1 | tr -d ' ')
    if [ -z "$stripped" ]; then
        echo ${#stripped}
    else
        echo "None"
    fi
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate " 	 ") = "0" ]]
}

run_test

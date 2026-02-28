#!/bin/bash
# $1 is a string
# $2 is a string
f() {
    text="$1"
    search_string="$2"
    indexes=()
    while [[ $text == *$search_string* ]]; do
        index=$(expr length "${text%$search_string*}")
        indexes+=($index)
        text=${text:0:$index}
    done
    echo ${indexes[@]}
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "ONBPICJOHRHDJOSNCPNJ9ONTHBQCJ" "J") = "28 19 12 6" ]]
}

run_test

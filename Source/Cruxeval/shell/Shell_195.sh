#!/bin/bash
# $1 is a string
f() {
    local text="$1"
    for p in 'acs' 'asp' 'scn'; do
        if [[ $text == $p* ]]; then
            text="${text#$p}"
        fi
        text="$text "
    done
    text="${text# }"
    echo "${text::-1}"
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "ilfdoirwirmtoibsac") = "ilfdoirwirmtoibsac  " ]]
}

run_test

#!/bin/bash
# $1 is a string
# $2 is a string
f() {
    local text="$1"
    local chars="$2"
    local -i len=${#text}
    local -i i

    while [[ "${text:len-3:1}" == "${chars}" ]]; do
        text="${text:0:len-3}${text:len-1}"
        len=${#text}
    done

    echo "${text}"
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "ellod\!p.nkyp.exa.bi.y.hain" ".n.in.ha.y") = "ellod\!p.nkyp.exa.bi.y.hain" ]]
}

run_test

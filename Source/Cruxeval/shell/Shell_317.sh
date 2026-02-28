#!/bin/bash
# $1 is a string
# $2 is a string
# $3 is a string
f() {
    local text="$1"
    local a="$2"
    local b="$3"
    text=$(echo "$text" | sed "s/$a/$b/g")
    echo "${text//"$b"/"$a"}"
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate " vup a zwwo oihee amuwuuw\! " "a" "u") = " vap a zwwo oihee amawaaw\! " ]]
}

run_test

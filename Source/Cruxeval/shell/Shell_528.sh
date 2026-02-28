#!/bin/bash
# $1 is a string
f() {
    s=$1
    b=''
    c=''
    for (( i=0; i<${#s}; i++ )); do
        c=$c${s:$i:1}
        if [[ ${s/$c} != *"$c"* ]]; then
            echo ${#c}
            return
        fi
    done
    echo 0
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "papeluchis") = "2" ]]
}

run_test

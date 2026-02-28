#!/bin/bash
# $1 is a string
f() {
    w=$1
    ls=($(echo $w | grep -o .))
    omw=''
    while [ ${#ls[@]} -gt 0 ]; do
        omw+=${ls[0]}
        ls=("${ls[@]:1}")
        if [ $(( ${#ls[@]} * 2 )) -gt ${#w} ]; then
            if [ "${w:${#ls[@]}}" == $omw ]; then
                echo true
                return 0
            fi
        fi
    done
    echo false
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "flak") = "false" ]]
}

run_test

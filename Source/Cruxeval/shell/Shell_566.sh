#!/bin/bash
# $1 is a string
# $2 is a string
f() {
    t=''
    t=$(echo -n "$1" | iconv -t $2 2>/dev/null)
    if [[ $? -eq 0 ]]; then
        if [[ ${t: -1} == $'\n' ]]; then
            t=${t%?}
        fi
        echo -n "$t"
    else
        echo -n "$t"
    fi
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "towaru" "UTF-8") = "towaru" ]]
}

run_test

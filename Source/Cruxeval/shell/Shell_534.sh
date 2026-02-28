#!/bin/bash
# $1 is a string
# $2 is a string
f() {
    sequence=$1
    value=$2
    i=$(echo $sequence | grep -bo "$value" | cut -d: -f1)
    i=$((i - ${#sequence} / 3))
    if (( i < 0 )); then
        i=0
    fi
    result=''
    for (( j=i; j<${#sequence}; j++ )); do
        if [ "${sequence:$j:1}" = "+" ]; then
            result+=$value
        else
            result+=${sequence:$j:1}
        fi
    done
    echo $result
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "hosu" "o") = "hosu" ]]
}

run_test

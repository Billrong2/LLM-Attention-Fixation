#!/bin/bash
# $1 is a string
# $2 is a string
f() {
    forest=$1
    animal=$2
    index=${forest%%$animal*}
    index=${#index}
    result=${forest:0:index}${forest:index+1}
    while [ $index -lt $(( ${#forest} - 1 )) ]; do
        result=${result:0:index}${forest:index+1:1}${result:index+1}
        index=$(( index + 1 ))
    done
    if [ $index -eq $(( ${#forest} - 1 )) ]; then
        result=${result:0:index}"-"
    fi
    echo $result
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "2imo 12 tfiqr." "m") = "2io 12 tfiqr.-" ]]
}

run_test

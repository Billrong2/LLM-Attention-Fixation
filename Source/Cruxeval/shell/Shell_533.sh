#!/bin/bash
# $1 is a string
# $2 is a two column CSV in key,value order
f() {
    query=$1
    base=$2
    net_sum=0

    IFS=',' read -r -a array <<< "$base"
    for element in "${array[@]}"
    do
        IFS=':' read -r -a pair <<< "$element"
        key=${pair[0]}
        val=${pair[1]}

        if [ "${key:0:1}" == "$query" ] && [ ${#key} -eq 3 ]; then
            net_sum=$(( net_sum - val ))
        elif [ "${key:2:1}" == "$query" ] && [ ${#key} -eq 3 ]; then
            net_sum=$(( net_sum + val ))
        fi
    done

    echo $net_sum
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "a" "") = "0" ]]
}

run_test

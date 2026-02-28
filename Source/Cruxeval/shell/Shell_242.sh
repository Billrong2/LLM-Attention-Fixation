#!/bin/bash
# $1 is a string
f() {
    local a
    a=$(echo $1 | awk -F':' '{print $1}')
    local b
    b=$(echo $1 | awk -F':' '{print $2}')
    if [ $(echo $a | awk '{print $NF}') = $(echo $b | awk '{print $1}') ]; then
        f "$(echo $a | rev | cut -d' ' -f2- | rev) $b"
    else
        echo $1
    fi
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "udhv zcvi nhtnfyd :erwuyawa pun") = "udhv zcvi nhtnfyd :erwuyawa pun" ]]
}

run_test

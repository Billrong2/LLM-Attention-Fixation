#!/bin/bash
# $1 is a string
# $2 is a string
f() {
    perc=$1
    full=$2
    reply=""
    i=0
    while [ "${perc:$i:1}" = "${full:$i:1}" ] && [ $i -lt ${#full} ] && [ $i -lt ${#perc} ]; do
        if [ "${perc:$i:1}" = "${full:$i:1}" ]; then
            reply+="yes "
        else
            reply+="no "
        fi
        i=$((i + 1))
    done
    echo "$reply"
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "xabxfiwoexahxaxbxs" "xbabcabccb") = "yes " ]]
}

run_test

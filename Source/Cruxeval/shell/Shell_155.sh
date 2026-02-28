#!/bin/bash
# $1 is a string
# $2 is an integer
f() {
    local ip=$1
    local n=$2
    local i=0
    local out=''
    
    for (( j=0; j<${#ip}; j++ )); do
        c=${ip:$j:1}
        if [ $i -eq $n ]; then
            out+='\n'
            i=0
        fi
        (( i++ ))
        out+=$c
    done
    
    echo $out
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "dskjs hjcdjnxhjicnn" "4") = "dskj\ns hj\ncdjn\nxhji\ncnn" ]]
}

run_test

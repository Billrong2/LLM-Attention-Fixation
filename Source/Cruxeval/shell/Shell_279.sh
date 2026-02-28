#!/bin/bash
# $1 is a string
f() {
    text=$1
    ans=''
    while [[ ! -z $text ]]; do
        x=$(echo $text | cut -d'(' -f1)
        sep=$(echo $text | cut -d'(' -f2)
        text=$(echo $text | cut -d'(' -f3-)
        
        ans=$x$sep${ans}
        ans=${ans}${text:0:1}${ans}
        text=${text:1}
    done
    echo $ans
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "") = "" ]]
}

run_test

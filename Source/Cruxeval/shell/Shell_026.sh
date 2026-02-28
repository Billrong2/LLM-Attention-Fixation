#!/bin/bash
# $1 is a string
# $2 is a string
f() {
    for i in $1; do
        if [[ $2 == *"$i"* ]]; then
            echo $(expr index "$1" "$i")+1
            return
        fi
        if [[ $i == *"." || $i == *". "* || $i == *" ." ]]; then
            echo 'error'
            return
        fi
    done
    echo '.'
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "qy. dg. rnvprt rse.. irtwv tx.." "wtwdoacb") = "error" ]]
}

run_test

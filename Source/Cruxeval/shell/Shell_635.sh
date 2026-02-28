#!/bin/bash
# $1 is a string
f() {
    valid_chars='- _+. /'
    text=$(echo $1 | tr '[:lower:]' '[:upper:]')
    for ((i=0; i<${#text}; i++)); do
        char=${text:$i:1}
        if [[ ! $char =~ [[:alnum:]] && "$valid_chars" != *"$char"* ]]; then
            echo false
            return
        fi
    done
    echo true
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "9.twCpTf.H7 HPeaQ^ C7I6U,C:YtW") = "false" ]]
}

run_test

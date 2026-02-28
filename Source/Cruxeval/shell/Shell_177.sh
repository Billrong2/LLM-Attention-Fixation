#!/bin/bash
# $1 is a string
f() {
    text=$1
    new_text=""
    for (( i=0; i<${#text}; i++ )); do
        char=${text:$i:1}
        if [ $((i % 2)) -eq 1 ]; then
            if [[ $char == [[:lower:]] ]]; then
                char=${char^^}
            else
                char=${char,,}
            fi
        fi
        new_text="$new_text$char"
    done
    echo $new_text
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "Hey DUdE THis \$nd^ &*&this@#") = "HEy Dude tHIs \$Nd^ &*&tHiS@#" ]]
}

run_test

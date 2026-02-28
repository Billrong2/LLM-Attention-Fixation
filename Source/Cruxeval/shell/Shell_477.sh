#!/bin/bash
# $1 is a string
f() {
    topic=$(echo $1 | rev | cut -d '|' -f 2- | rev)
    problem=$(echo $1 | rev | cut -d '|' -f 1 | rev)
    if [ "$problem" = "r" ]; then
        problem=$(echo $topic | sed 's/u/p/g')
    fi
    echo "$topic $problem"
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "|xduaisf") = " xduaisf" ]]
}

run_test

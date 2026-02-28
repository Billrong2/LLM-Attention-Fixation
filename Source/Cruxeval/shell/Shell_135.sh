#!/bin/bash
# 
f() {
    echo "Russia Kazakhstan"
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate ) = "Russia Kazakhstan" ]]
}

run_test

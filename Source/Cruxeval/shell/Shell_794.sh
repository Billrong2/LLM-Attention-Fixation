#!/bin/bash
# $1 is a string
f() {
    echo $1 | tr -dc 'a-zA-Z0-9'
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "\"\\%\$ normal chars \$%~ qwet42'") = "normalcharsqwet42" ]]
}

run_test

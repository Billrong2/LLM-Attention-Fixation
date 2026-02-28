#!/bin/bash
# $1 is a string
f() {
    echo "$1" | tr '[:lower:]' '[:upper:]'
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "Jaafodsfa SOdofj AoaFjIs  JAFasIdfSa1") = "JAAFODSFA SODOFJ AOAFJIS  JAFASIDFSA1" ]]
}

run_test

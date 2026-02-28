#!/bin/bash
# $1 is a string
f() {
    out=""
    for ((i=0; i<${#1}; i++)); do
        if [ "${1:i:1}" == "$(tr '[:lower:]' '[:upper:]' <<< "${1:i:1}")" ]; then
            out+=`tr '[:upper:]' '[:lower:]' <<< "${1:i:1}"`
        else
            out+=`tr '[:lower:]' '[:upper:]' <<< "${1:i:1}"`
        fi
    done
    echo $out
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate ",wPzPppdl/") = ",WpZpPPDL/" ]]
}

run_test

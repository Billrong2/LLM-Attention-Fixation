#!/bin/bash
# $1 is a dictionary string where keys and values are delimited by "::"
# $2 is a list string where items are delimited by ","
f() {
    read -r -d '' -a del_array <<<"$2"
    IFS='::' read -r -d '' -a dict_array <<<"$1"
    dict_string="$1"
    for key in "${del_array[@]}"; do
        dict_string=$(echo "$dict_string" | sed "s/$key::[^:]*//")
    done
    echo "$dict_string"
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "1,b" "1") = "1,b" ]]
}

run_test

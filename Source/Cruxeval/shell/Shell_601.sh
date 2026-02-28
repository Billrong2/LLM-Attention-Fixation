#!/bin/bash
# $1 is a string
f() {
    text=$1
    t=5
    tab=()
    for (( i=0; i<${#text}; i++ )); do
        char=${text:$i:1}
        if [[ $char == *['aeiouy']* ]]; then
            char=$(echo "$char" | tr '[:lower:]' '[:upper:]')
        fi
        tab+=("${char}")
    done

    for i in "${tab[@]}"; do
        result+=$(printf "$i"'%.0s' $(seq $t))
        result+=" "
    done
    echo "${result::-1}"  # Remove the last space
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "csharp") = "ccccc sssss hhhhh AAAAA rrrrr ppppp" ]]
}

run_test

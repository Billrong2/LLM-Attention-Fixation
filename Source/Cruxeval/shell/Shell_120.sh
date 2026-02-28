#!/bin/bash
# $1 is a two column CSV in key,value order
f() {
    while IFS=',' read -r country language; do
        if [[ ! -z $country && ! -z $language ]]; then
            if [[ -z ${language_country[$language]} ]]; then
                language_country[$language]=()
            fi
            language_country[$language]+=$country
        fi
    done < $1

    for lang in "${!language_country[@]}"; do
        echo "$lang:${language_country[$lang]}"
    done
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "") = "" ]]
}

run_test

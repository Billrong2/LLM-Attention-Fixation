<?php
function f($sentence) {
    if ($sentence == '') {
        return '';
    }
    $sentence = str_replace('(', '', $sentence);
    $sentence = str_replace(')', '', $sentence);
    $sentence = ucfirst(strtolower($sentence));
    return str_replace(' ', '', $sentence);
}

function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate("(A (b B))") !== "Abb") { throw new Exception("Test failed!"); }
}

test();

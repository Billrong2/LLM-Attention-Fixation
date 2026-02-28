<?php
function f($text) {
    $trans = array_combine(str_split('"\'><'), str_split('9833'));
    return strtr($text, $trans);
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate("Transform quotations\"\nnot into numbers.") !== "Transform quotations9\nnot into numbers.") { throw new Exception("Test failed!"); }
}

test();

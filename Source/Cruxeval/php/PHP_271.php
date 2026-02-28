<?php
function f($text, $c) {
    $ls = str_split($text);
    if (strpos($text, $c) === false) {
        throw new Exception("Text has no $c");
    }
    unset($ls[strrpos($text, $c)]);
    return implode('', $ls);
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate("uufhl", "l") !== "uufh") { throw new Exception("Test failed!"); }
}

test();

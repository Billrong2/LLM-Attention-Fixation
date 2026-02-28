<?php
function f($text, $char) {
    if (strpos($text, $char) !== false) {
        $text = array_filter(array_map('trim', explode($char, $text)));
        if (count($text) > 1) {
            return true;
        }
    }
    return false;
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate("only one line", " ") !== true) { throw new Exception("Test failed!"); }
}

test();

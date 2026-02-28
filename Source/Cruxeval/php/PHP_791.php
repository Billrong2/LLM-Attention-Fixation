<?php
function f($integer, $n) {
    $i = 1;
    $text = strval($integer);
    while (($i + strlen($text)) < $n) {
        $i += strlen($text);
    }
    return str_pad($text, $i+strlen($text), '0', STR_PAD_LEFT);
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate(8999, 2) !== "08999") { throw new Exception("Test failed!"); }
}

test();

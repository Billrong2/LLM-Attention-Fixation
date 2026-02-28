<?php
function f($text) {
    $text = strtolower($text);
    $head = $text[0];
    $tail = substr($text, 1);
    return strtoupper($head) . $tail;
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate("Manolo") !== "Manolo") { throw new Exception("Test failed!"); }
}

test();

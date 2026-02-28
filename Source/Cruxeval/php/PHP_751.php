<?php
function f($text, $char, $min_count) {
    $count = substr_count($text, $char);
    if ($count < $min_count) {
        return strtoupper($text);
    }
    return $text;
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate("wwwwhhhtttpp", "w", 3) !== "wwwwhhhtttpp") { throw new Exception("Test failed!"); }
}

test();

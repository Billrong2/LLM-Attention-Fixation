<?php
function f($text, $s, $e) {
    $sublist = substr($text, $s, $e - $s);
    if (empty($sublist)) {
        return -1;
    }
    return strpos($sublist, min(str_split($sublist)));
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate("happy", 0, 3) !== 1) { throw new Exception("Test failed!"); }
}

test();

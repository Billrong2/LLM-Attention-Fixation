<?php
function f($text, $letter) {
    if (strpos($text, $letter) !== false) {
        $start = strpos($text, $letter);
        return substr($text, $start + 1) . substr($text, 0, $start + 1);
    }
    return $text;
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate("19kefp7", "9") !== "kefp719") { throw new Exception("Test failed!"); }
}

test();

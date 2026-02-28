<?php
function f($text, $prefix) {
    if (strpos($text, $prefix) === 0) {
        return substr($text, strlen($prefix));
    }
    if (strpos($text, $prefix) !== false) {
        return trim(str_replace($prefix, '', $text));
    }
    return strtoupper($text);
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate("abixaaaily", "al") !== "ABIXAAAILY") { throw new Exception("Test failed!"); }
}

test();

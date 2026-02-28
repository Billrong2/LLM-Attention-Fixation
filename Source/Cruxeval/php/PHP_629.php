<?php
function f($text, $dng) {
    if (strpos($text, $dng) === false) {
        return $text;
    }
    if (substr($text, -strlen($dng)) === $dng) {
        return substr($text, 0, -strlen($dng));
    }
    return substr($text, 0, -1) . f(substr($text, 0, -2), $dng);
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate("catNG", "NG") !== "cat") { throw new Exception("Test failed!"); }
}

test();

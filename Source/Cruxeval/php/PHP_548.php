<?php
function f($text, $suffix) {
    if ($suffix && $text && substr($text, -strlen($suffix)) === $suffix) {
        return substr($text, 0, -strlen($suffix));
    } else {
        return $text;
    }
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate("spider", "ed") !== "spider") { throw new Exception("Test failed!"); }
}

test();

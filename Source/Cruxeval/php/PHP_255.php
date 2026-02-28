<?php
function f($text, $fill, $size) {
    if ($size < 0) {
        $size = abs($size);
    }
    if (strlen($text) > $size) {
        return substr($text, strlen($text) - $size);
    }
    return str_pad($text, $size, $fill, STR_PAD_LEFT);
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate("no asw", "j", 1) !== "w") { throw new Exception("Test failed!"); }
}

test();

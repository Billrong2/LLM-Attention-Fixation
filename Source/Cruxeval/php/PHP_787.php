<?php
function f($text) {
    if (strlen($text) == 0) {
        return '';
    }
    $text = strtolower($text);
    return ucfirst($text);
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate("xzd") !== "Xzd") { throw new Exception("Test failed!"); }
}

test();

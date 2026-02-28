<?php
function f($text, $prefix) {
    while (strpos($text, $prefix) === 0) {
        $text = substr($text, strlen($prefix)) ?: $text;
    }
    return $text;
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate("ndbtdabdahesyehu", "n") !== "dbtdabdahesyehu") { throw new Exception("Test failed!"); }
}

test();

<?php
function f($value) {
    $parts = explode(' ', $value);
    $parts = array_filter($parts, function($key) {
        return $key % 2 == 0;
    }, ARRAY_FILTER_USE_KEY);
    return implode('', $parts);
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate("coscifysu") !== "coscifysu") { throw new Exception("Test failed!"); }
}

test();

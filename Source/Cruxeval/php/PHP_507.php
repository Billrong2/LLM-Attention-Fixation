<?php
function f($text, $search) {
    $result = strtolower($text);
    return strpos($result, strtolower($search));
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate("car hat", "car") !== 0) { throw new Exception("Test failed!"); }
}

test();

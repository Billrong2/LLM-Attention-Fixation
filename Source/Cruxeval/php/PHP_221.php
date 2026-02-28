<?php
function f($text, $delim) {
    list($first, $second) = explode($delim, $text, 2);
    return $second . $delim . $first;
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate("bpxa24fc5.", ".") !== ".bpxa24fc5") { throw new Exception("Test failed!"); }
}

test();

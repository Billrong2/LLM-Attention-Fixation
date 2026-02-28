<?php
function f($s) {
    return implode('', array_map('strtolower', str_split($s)));
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate("abcDEFGhIJ") !== "abcdefghij") { throw new Exception("Test failed!"); }
}

test();

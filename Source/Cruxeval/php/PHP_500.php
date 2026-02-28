<?php
function f($text, $delim) {
    return strrev(substr($text, 0, strpos(strrev($text), $delim)));
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate("dsj osq wi w", " ") !== "d") { throw new Exception("Test failed!"); }
}

test();

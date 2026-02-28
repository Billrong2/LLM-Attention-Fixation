<?php
function f($text) {
    return strtoupper($text) === strval($text);
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate("VTBAEPJSLGAHINS") !== true) { throw new Exception("Test failed!"); }
}

test();

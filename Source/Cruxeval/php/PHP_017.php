<?php
function f($text) {
    return strpos($text, ",");
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate("There are, no, commas, in this text") !== 9) { throw new Exception("Test failed!"); }
}

test();

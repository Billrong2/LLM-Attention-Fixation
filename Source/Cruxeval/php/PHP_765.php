<?php
function f($text) {
    return count(preg_split("/\d/", $text)) - 1;
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate("so456") !== 3) { throw new Exception("Test failed!"); }
}

test();

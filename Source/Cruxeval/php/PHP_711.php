<?php
function f($text) {
    return str_replace("\n", "\t", $text);
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate("apples\n	\npears\n	\nbananas") !== "apples			pears			bananas") { throw new Exception("Test failed!"); }
}

test();

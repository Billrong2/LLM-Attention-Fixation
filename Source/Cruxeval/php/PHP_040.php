<?php
function f($text) {
    return str_pad($text, strlen($text) + 1, "#", STR_PAD_RIGHT);
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate("the cow goes moo") !== "the cow goes moo#") { throw new Exception("Test failed!"); }
}

test();

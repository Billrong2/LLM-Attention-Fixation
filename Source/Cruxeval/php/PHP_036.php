<?php
function f($text, $chars) {
    return ($text !== "") ? rtrim($text, $chars) : $text;
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate("ha", "") !== "ha") { throw new Exception("Test failed!"); }
}

test();

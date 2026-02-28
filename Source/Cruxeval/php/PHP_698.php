<?php
function f($text) {
    return str_replace(')', '', $text);
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate("(((((((((((d))))))))).))))(((((") !== "(((((((((((d.(((((") { throw new Exception("Test failed!"); }
}

test();

<?php
function f($text) {
    return str_replace('\\"', '"', $text);
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate("Because it intrigues them") !== "Because it intrigues them") { throw new Exception("Test failed!"); }
}

test();

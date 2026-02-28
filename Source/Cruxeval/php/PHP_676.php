<?php
function f($text, $tab_size) {
    return str_replace('\t', str_repeat(' ', $tab_size), $text);
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate("a", 100) !== "a") { throw new Exception("Test failed!"); }
}

test();

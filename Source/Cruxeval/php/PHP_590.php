<?php
function f($text) {
    for ($i = 10; $i > 0; $i--) {
        $text = ltrim($text, strval($i));
    }
    return $text;
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate("25000   $") !== "5000   $") { throw new Exception("Test failed!"); }
}

test();

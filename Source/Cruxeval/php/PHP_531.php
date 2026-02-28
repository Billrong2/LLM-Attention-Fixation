<?php
function f($text, $x) {
    $prefix = substr($text, 0, strlen($x));
    if ($prefix != $x) {
        return f(substr($text, 1), $x);
    } else {
        return $text;
    }
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate("Ibaskdjgblw asdl ", "djgblw") !== "djgblw asdl ") { throw new Exception("Test failed!"); }
}

test();

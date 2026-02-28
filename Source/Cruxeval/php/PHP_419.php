<?php
function f($text, $value) {
    if (strpos($text, $value) === false) {
        return '';
    }
    return explode($value, $text)[0];
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate("mmfbifen", "i") !== "mmfb") { throw new Exception("Test failed!"); }
}

test();

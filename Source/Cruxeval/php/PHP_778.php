<?php
function f($prefix, $text) {
    if (strpos($text, $prefix) === 0) {
        return $text;
    } else {
        return $prefix . $text;
    }
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate("mjs", "mjqwmjsqjwisojqwiso") !== "mjsmjqwmjsqjwisojqwiso") { throw new Exception("Test failed!"); }
}

test();

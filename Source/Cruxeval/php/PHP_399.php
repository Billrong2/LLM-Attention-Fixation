<?php
function f($text, $old, $new) {
    if (strlen($old) > 3) {
        return $text;
    }
    if (strpos($text, $old) !== false && strpos($text, ' ') === false) {
        return str_replace($old, str_repeat($new, strlen($old)), $text);
    }
    while (strpos($text, $old) !== false) {
        $text = str_replace($old, $new, $text);
    }
    return $text;
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate("avacado", "va", "-") !== "a--cado") { throw new Exception("Test failed!"); }
}

test();

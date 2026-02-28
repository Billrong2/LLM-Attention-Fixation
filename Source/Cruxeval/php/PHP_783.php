<?php
function f($text, $comparison) {
    $length = strlen($comparison);
    if ($length <= strlen($text)) {
        for ($i = 0; $i < $length; $i++) {
            if ($comparison[$length - $i - 1] != $text[strlen($text) - $i - 1]) {
                return $i;
            }
        }
    }
    return $length;
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate("managed", "") !== 0) { throw new Exception("Test failed!"); }
}

test();

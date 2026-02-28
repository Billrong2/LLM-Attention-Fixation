<?php
function f($text, $old, $new) {
    $text2 = str_replace($old, $new, $text);
    $old2 = strrev($old);
    while (strpos($text2, $old2) !== false) {
        $text2 = str_replace($old2, $new, $text2);
    }
    return $text2;
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate("some test string", "some", "any") !== "any test string") { throw new Exception("Test failed!"); }
}

test();

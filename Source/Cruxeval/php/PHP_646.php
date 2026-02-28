<?php
function f($text, $count) {
    for ($i = 0; $i < $count; $i++) {
        $text = strrev($text);
    }
    return $text;
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate("aBc, ,SzY", 2) !== "aBc, ,SzY") { throw new Exception("Test failed!"); }
}

test();

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
    if (candidate("439m2670hlsw", 3) !== "wslh0762m934") { throw new Exception("Test failed!"); }
}

test();

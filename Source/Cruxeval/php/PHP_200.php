<?php
function f($text, $value) {
    $length = strlen($text);
    $index = 0;
    while ($length > 0) {
        $value = $text[$index] . $value;
        $length--;
        $index++;
    }
    return $value;
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate("jao mt", "house") !== "tm oajhouse") { throw new Exception("Test failed!"); }
}

test();

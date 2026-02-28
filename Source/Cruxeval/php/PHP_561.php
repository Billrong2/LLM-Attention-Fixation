<?php
function f($text, $digit) {
    $count = substr_count($text, $digit);
    return intval($digit) * $count;
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate("7Ljnw4Lj", "7") !== 7) { throw new Exception("Test failed!"); }
}

test();

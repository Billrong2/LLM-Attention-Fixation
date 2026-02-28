<?php
function f($text) {
    $n = strpos($text, '8');
    return str_repeat('x0', $n);
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate("sa832d83r xd 8g 26a81xdf") !== "x0x0") { throw new Exception("Test failed!"); }
}

test();

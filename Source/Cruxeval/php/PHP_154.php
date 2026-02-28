<?php
function f($s, $c) {
    $s = explode(' ', $s);
    return $c . "  " . implode('  ', array_reverse($s));
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate("Hello There", "*") !== "*  There  Hello") { throw new Exception("Test failed!"); }
}

test();

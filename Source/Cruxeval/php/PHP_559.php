<?php
function f($n) {
    $n = strval($n);
    return $n[0] . '.' . str_replace('-', '_', substr($n, 1));
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate("first-second-third") !== "f.irst_second_third") { throw new Exception("Test failed!"); }
}

test();

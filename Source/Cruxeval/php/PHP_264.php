<?php
function f($test_str) {
    $s = str_replace('a', 'A', $test_str);
    return str_replace('e', 'A', $s);
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate("papera") !== "pApArA") { throw new Exception("Test failed!"); }
}

test();

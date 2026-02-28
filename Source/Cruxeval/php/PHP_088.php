<?php
function f($s1, $s2) {
    if (substr($s2, -strlen($s1)) === $s1) {
        $s2 = substr($s2, 0, -strlen($s1));
    }
    return $s2;
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate("he", "hello") !== "hello") { throw new Exception("Test failed!"); }
}

test();

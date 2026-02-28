<?php
function f($s, $amount) {
    return str_repeat('z', $amount - strlen($s)) . $s;
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate("abc", 8) !== "zzzzzabc") { throw new Exception("Test failed!"); }
}

test();

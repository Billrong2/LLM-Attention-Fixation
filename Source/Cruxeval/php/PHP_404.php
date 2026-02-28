<?php
function f($no) {
    $d = array_fill_keys($no, false);
    return count(array_keys($d));
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate(array("l", "f", "h", "g", "s", "b")) !== 6) { throw new Exception("Test failed!"); }
}

test();

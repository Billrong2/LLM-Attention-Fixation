<?php
function f($arr) {
    return array_reverse($arr);
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate(array(2, 0, 1, 9999, 3, -5)) !== array(-5, 3, 9999, 1, 0, 2)) { throw new Exception("Test failed!"); }
}

test();

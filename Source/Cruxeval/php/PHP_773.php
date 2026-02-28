<?php
function f($nums, $n) {
    return array_splice($nums, $n, 1)[0];
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate(array(-7, 3, 1, -1, -1, 0, 4), 6) !== 4) { throw new Exception("Test failed!"); }
}

test();

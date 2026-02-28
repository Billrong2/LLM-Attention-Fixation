<?php
function f($m) {
    $reversed = array_reverse($m);
    return $reversed;
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate(array(-4, 6, 0, 4, -7, 2, -1)) !== array(-1, 2, -7, 4, 0, 6, -4)) { throw new Exception("Test failed!"); }
}

test();

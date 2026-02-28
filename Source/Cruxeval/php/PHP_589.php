<?php
function f($num) {
    $num[] = end($num);
    return $num;
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate(array(-70, 20, 9, 1)) !== array(-70, 20, 9, 1, 1)) { throw new Exception("Test failed!"); }
}

test();

<?php
function f($number) {
    return is_numeric($number) && is_int($number + 0);
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate("dummy33;d") !== false) { throw new Exception("Test failed!"); }
}

test();

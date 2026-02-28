<?php
function f($s, $n) {
    return strtolower($s) === strtolower($n);
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate("daaX", "daaX") !== true) { throw new Exception("Test failed!"); }
}

test();

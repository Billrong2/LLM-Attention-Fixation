<?php
function f($s) {
    return str_replace(['a', 'r'], '', $s);
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate("rpaar") !== "p") { throw new Exception("Test failed!"); }
}

test();

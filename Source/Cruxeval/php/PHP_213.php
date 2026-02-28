<?php
function f($s) {
    return str_replace(['(', ')'], ['[', ']'], $s);
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate("(ac)") !== "[ac]") { throw new Exception("Test failed!"); }
}

test();

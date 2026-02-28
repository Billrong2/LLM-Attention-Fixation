<?php
function f($s) {
    return strrev(trim($s));
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate("ab        ") !== "ba") { throw new Exception("Test failed!"); }
}

test();

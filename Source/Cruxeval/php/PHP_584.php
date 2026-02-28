<?php
function f($txt) {
    return vsprintf($txt, array_fill(0, 20, '0'));
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate("5123807309875480094949830") !== "5123807309875480094949830") { throw new Exception("Test failed!"); }
}

test();

<?php
function f($file) {
    return strpos($file, "\n");
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate("n wez szize lnson tilebi it 504n.\n") !== 33) { throw new Exception("Test failed!"); }
}

test();

<?php
function f($sentence) {
    for ($i = 0; $i < strlen($sentence); $i++) {
        if (ord($sentence[$i]) > 127) {
            return false;
        }
    }
    return true;
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate("1z1z1") !== true) { throw new Exception("Test failed!"); }
}

test();

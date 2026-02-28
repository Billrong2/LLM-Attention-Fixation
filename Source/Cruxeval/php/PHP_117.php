<?php
function f($numbers) {
    for ($i = 0; $i < strlen($numbers); $i++) {
        if (substr_count($numbers, '3') > 1) {
            return $i;
        }
    }
    return -1;
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate("23157") !== -1) { throw new Exception("Test failed!"); }
}

test();

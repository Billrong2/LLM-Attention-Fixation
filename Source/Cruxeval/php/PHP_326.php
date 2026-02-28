<?php
function f($text) {
    $number = 0;
    for ($i = 0; $i < strlen($text); $i++) {
        if (is_numeric($text[$i])) {
            $number++;
        }
    }
    return $number;
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate("Thisisastring") !== 0) { throw new Exception("Test failed!"); }
}

test();

<?php
function f($array) {
    foreach ($array as $key => $value) {
        if ($value < 0) {
            unset($array[$key]);
        }
    }
    return array_values($array);
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate(array()) !== array()) { throw new Exception("Test failed!"); }
}

test();

<?php
function f($array, $elem) {
    return array_count_values($array)[$elem] + $elem;
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate(array(1, 1, 1), -2) !== -2) { throw new Exception("Test failed!"); }
}

test();

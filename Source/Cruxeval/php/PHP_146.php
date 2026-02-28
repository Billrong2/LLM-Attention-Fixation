<?php
function f($single_digit) {
    $result = [];
    for ($c = 1; $c <= 10; $c++) {
        if ($c != $single_digit) {
            $result[] = $c;
        }
    }
    return $result;
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate(5) !== array(1, 2, 3, 4, 6, 7, 8, 9, 10)) { throw new Exception("Test failed!"); }
}

test();

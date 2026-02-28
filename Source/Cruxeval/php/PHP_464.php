<?php
function f($ans) {
    if (is_numeric($ans)) {
        $total = intval($ans) * 4 - 50;
        $total -= count(array_diff(str_split($ans), str_split('02468'))) * 100;
        return $total;
    }
    return 'NAN';
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate("0") !== -50) { throw new Exception("Test failed!"); }
}

test();

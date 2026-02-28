<?php
function f($array, $x, $i) {
    if ($i < -count($array) || $i > count($array) - 1) {
        return 'no';
    }
    $temp = $array[$i];
    $array[$i] = $x;
    return $array;
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate(array(1, 2, 3, 4, 5, 6, 7, 8, 9, 10), 11, 4) !== array(1, 2, 3, 4, 11, 6, 7, 8, 9, 10)) { throw new Exception("Test failed!"); }
}

test();

<?php
function f($array, $ind, $elem) {
    if ($ind < 0) {
        array_splice($array, -5, 0, $elem);
    } elseif ($ind > count($array)) {
        array_splice($array, count($array), 0, $elem);
    } else {
        array_splice($array, $ind + 1, 0, $elem);
    }
    return $array;
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate(array(1, 5, 8, 2, 0, 3), 2, 7) !== array(1, 5, 8, 7, 2, 0, 3)) { throw new Exception("Test failed!"); }
}

test();

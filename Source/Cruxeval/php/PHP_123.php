<?php
function f($array, $elem) {
    foreach ($array as $idx => $e) {
        if ($e > $elem && $array[$idx - 1] < $elem) {
            array_splice($array, $idx, 0, $elem);
        }
    }
    return $array;
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate(array(1, 2, 3, 5, 8), 6) !== array(1, 2, 3, 5, 6, 8)) { throw new Exception("Test failed!"); }
}

test();

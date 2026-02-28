<?php
function f($array, $elem) {
    $ind = array_search($elem, $array);
    return $ind * 2 + $array[count($array) - $ind - 1] * 3;
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate(array(-1, 2, 1, -8, 2), 2) !== -22) { throw new Exception("Test failed!"); }
}

test();

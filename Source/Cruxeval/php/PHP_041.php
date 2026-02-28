<?php
function f($array, $values) {
    $reversed = array_reverse($array);
    foreach ($values as $value) {
        array_splice($array, count($array) / 2, 0, $value);
    }
    $reversed = array_reverse($array);
    return $reversed;
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate(array(58), array(21, 92)) !== array(58, 92, 21)) { throw new Exception("Test failed!"); }
}

test();

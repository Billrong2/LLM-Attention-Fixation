<?php
function f($numbers, $index) {
    if ($index > count($numbers)) {
        return $numbers;
    }
    $slice = array_slice($numbers, $index);
    foreach ($slice as $n) {
        array_splice($numbers, $index, 0, $n);
        $index += 1;
    }
    return array_slice($numbers, 0, $index);
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate(array(-2, 4, -4), 0) !== array(-2, 4, -4)) { throw new Exception("Test failed!"); }
}

test();

<?php
function f($matrix) {
    array_reverse($matrix);
    $result = [];
    foreach ($matrix as $primary) {
        max($primary);
        rsort($primary);
        $result[] = $primary;
    }
    return $result;
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate(array(array(1, 1, 1, 1))) !== array(array(1, 1, 1, 1))) { throw new Exception("Test failed!"); }
}

test();

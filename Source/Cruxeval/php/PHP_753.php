<?php
function f($bag) {
    $values = array_values($bag);
    $tbl = [];
    for ($v = 0; $v < 100; $v++) {
        if (in_array($v, $values)) {
            $tbl[$v] = array_count_values($values)[$v];
        }
    }
    return $tbl;
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate(array(0 => 0, 1 => 0, 2 => 0, 3 => 0, 4 => 0)) !== array(0 => 5)) { throw new Exception("Test failed!"); }
}

test();

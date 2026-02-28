<?php
function f($query, $base) {
    $net_sum = 0;
    foreach ($base as $key => $val) {
        if ($key[0] == $query && strlen($key) == 3) {
            $net_sum -= $val;
        } elseif ($key[strlen($key) - 1] == $query && strlen($key) == 3) {
            $net_sum += $val;
        }
    }
    return $net_sum;
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate("a", array()) !== 0) { throw new Exception("Test failed!"); }
}

test();

<?php
function f($array, $target) {
    $count = 0;
    $i = 1;
    for ($j = 1; $j < count($array); $j++) {
        if (($array[$j] > $array[$j-1]) && ($array[$j] <= $target)) {
            $count += $i;
        } elseif ($array[$j] <= $array[$j-1]) {
            $i = 1;
        } else {
            $i += 1;
        }
    }
    return $count;
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate(array(1, 2, -1, 4), 2) !== 1) { throw new Exception("Test failed!"); }
}

test();

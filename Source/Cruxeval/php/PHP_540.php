<?php
function f($a) {
    $b = $a;
    for ($k = 0; $k < count($a) - 1; $k += 2) {
        array_splice($b, $k + 1, 0, $b[$k]);
    }
    array_push($b, $b[0]);
    return $b;
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate(array(5, 5, 5, 6, 4, 9)) !== array(5, 5, 5, 5, 5, 5, 6, 4, 9, 5)) { throw new Exception("Test failed!"); }
}

test();

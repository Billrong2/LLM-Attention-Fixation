<?php
function f($array, $elem) {
    $elem = strval($elem);
    $d = 0;
    foreach ($array as $i) {
        if (strval($i) === $elem) {
            $d += 1;
        }
    }
    return $d;
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate(array(-1, 2, 1, -8, -8, 2), 2) !== 2) { throw new Exception("Test failed!"); }
}

test();

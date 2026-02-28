<?php
function f($n) {
    foreach (str_split($n) as $i) {
        if (!is_numeric($i)) {
            $n = -1;
            break;
        }
    }
    return $n;
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate("6 ** 2") !== -1) { throw new Exception("Test failed!"); }
}

test();

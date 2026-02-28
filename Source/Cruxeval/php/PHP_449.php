<?php
function f($x) {
    $n = strlen($x);
    $i = 0;
    while ($i < $n && is_numeric($x[$i])) {
        $i++;
    }
    return $i === $n;
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate("1") !== true) { throw new Exception("Test failed!"); }
}

test();

<?php
function f($num) {
    $s = str_repeat('<', 10);
    if ($num % 2 == 0) {
        return $s;
    } else {
        return $num - 1;
    }
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate(21) !== 20) { throw new Exception("Test failed!"); }
}

test();

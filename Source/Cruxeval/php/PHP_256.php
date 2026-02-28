<?php
function f($text, $sub) {
    $a = 0;
    $b = strlen($text) - 1;

    while ($a <= $b) {
        $c = ($a + $b) / 2;
        if (strrpos($text, $sub) >= $c) {
            $a = $c + 1;
        } else {
            $b = $c - 1;
        }
    }

    return $a;
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate("dorfunctions", "2") !== 0) { throw new Exception("Test failed!"); }
}

test();

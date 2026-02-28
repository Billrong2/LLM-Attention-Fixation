<?php
function f($s, $n, $c) {
    $width = strlen($c) * $n;
    while (strlen($s) < $width) {
        $s = $c . $s;
    }
    return $s;
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate(".", 0, "99") !== ".") { throw new Exception("Test failed!"); }
}

test();

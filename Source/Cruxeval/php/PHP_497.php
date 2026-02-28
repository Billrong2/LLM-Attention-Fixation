<?php
function f($n) {
    $b = strval($n);
    $b = str_split($b);
    for ($i = 2; $i < count($b); $i++) {
        $b[$i] .= '+';
    }
    return $b;
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate(44) !== array("4", "4")) { throw new Exception("Test failed!"); }
}

test();

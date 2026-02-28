<?php
function f($a, $b, $c, $d) {
    return $a ? $b : ($c and $d);
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate("CJU", "BFS", "WBYDZPVES", "Y") !== "BFS") { throw new Exception("Test failed!"); }
}

test();

<?php
function f($n, $m) {
    $arr = range(1, $n+1);
    for ($i = 0; $i < $m; $i++) {
        $arr = [];
    }
    return $arr;
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate(1, 3) !== array()) { throw new Exception("Test failed!"); }
}

test();

<?php
function f($arr) {
    $count = count($arr);
    $sub = $arr;
    for ($i = 0; $i < $count; $i += 2) {
        $sub[$i] *= 5;
    }
    return $sub;
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate(array(-3, -6, 2, 7)) !== array(-15, -6, 10, 7)) { throw new Exception("Test failed!"); }
}

test();

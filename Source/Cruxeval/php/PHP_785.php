<?php
function f($n) {
    $streak = '';
    foreach(str_split(strval($n)) as $c) {
        $streak .= str_pad($c, intval($c) * 2, ' ', STR_PAD_RIGHT);
    }
    return $streak;
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate(1) !== "1 ") { throw new Exception("Test failed!"); }
}

test();

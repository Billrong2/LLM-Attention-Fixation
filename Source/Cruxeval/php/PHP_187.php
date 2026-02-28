<?php
function f($d, $index) {
    $length = count($d);
    $idx = $index % $length;
    $v = array_pop($d);
    for ($i = 0; $i < $idx; $i++) {
        array_pop($d);
    }
    return $v;
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate(array(27 => 39), 1) !== 39) { throw new Exception("Test failed!"); }
}

test();

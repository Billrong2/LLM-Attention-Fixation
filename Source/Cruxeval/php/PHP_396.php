<?php
function f($ets) {
    while (!empty($ets)) {
        $pair = array_pop($ets);
        $k = $pair[0];
        $v = $pair[1];
        $ets[$k] = $v**2;
    }
    return $ets;
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate(array()) !== array()) { throw new Exception("Test failed!"); }
}

test();

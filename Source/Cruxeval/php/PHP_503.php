<?php
function f($d) {
    $result = array_fill(0, count($d), NULL);
    $a = $b = 0;
    while(!empty($d)) {
        $result[$a] = array_pop($d);
        $a = $b;
        $b = ($b + 1) % count($result);
    }
    return $result;
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate(array()) !== array()) { throw new Exception("Test failed!"); }
}

test();

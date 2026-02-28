<?php
function f($line, $equalityMap) {
    $rs = array_reduce($equalityMap, function($acc, $k) {
        $acc[$k[0]] = $k[1];
        return $acc;
    }, []);
    return strtr($line, $rs);
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate("abab", array(array("a", "b"), array("b", "a"))) !== "baba") { throw new Exception("Test failed!"); }
}

test();

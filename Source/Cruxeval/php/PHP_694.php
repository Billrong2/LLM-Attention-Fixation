<?php
function f($d) {
    $i = count($d) - 1;
    $keys = array_keys($d);
    $key = $keys[$i];
    unset($d[$key]);
    return array($key, $d);
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate(array("e" => 1, "d" => 2, "c" => 3)) !== array("c", array("e" => 1, "d" => 2))) { throw new Exception("Test failed!"); }
}

test();

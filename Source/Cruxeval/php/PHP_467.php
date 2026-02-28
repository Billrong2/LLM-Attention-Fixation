<?php
function f($nums) {
    $copy = $nums;
    $newDict = array();
    foreach ($copy as $k => $value) {
        $newDict[$k] = count($copy[$k]);
    }
    return $newDict;
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate(array()) !== array()) { throw new Exception("Test failed!"); }
}

test();

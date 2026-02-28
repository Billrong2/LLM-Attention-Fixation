<?php
function f($strs) {
    $strs = explode(' ', $strs);
    for ($i = 1; $i < count($strs); $i += 2) {
        $strs[$i] = strrev($strs[$i]);
    }
    return implode(' ', $strs);
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate("K zBK") !== "K KBz") { throw new Exception("Test failed!"); }
}

test();

<?php
function f($s1, $s2) {
    $len1 = strlen($s1);
    $len2 = strlen($s2);
    for ($k = 0; $k < $len2 + $len1; $k++) {
        $s1 .= $s1[0];
        if (strpos($s1, $s2) !== false) {
            return true;
        }
    }
    return false;
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate("Hello", ")") !== false) { throw new Exception("Test failed!"); }
}

test();

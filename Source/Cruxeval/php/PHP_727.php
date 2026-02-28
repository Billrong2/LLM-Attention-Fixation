<?php
function f($numbers, $prefix) {
    $result = array();
    foreach ($numbers as $n) {
        if (strlen($n) > strlen($prefix) && strpos($n, $prefix) === 0) {
            $result[] = substr($n, strlen($prefix));
        } else {
            $result[] = $n;
        }
    }
    sort($result);
    return $result;
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate(array("ix", "dxh", "snegi", "wiubvu"), "") !== array("dxh", "ix", "snegi", "wiubvu")) { throw new Exception("Test failed!"); }
}

test();

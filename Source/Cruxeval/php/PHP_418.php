<?php
function f($s, $p) {
    $pos = strpos($s, $p);
    if ($pos === false) {
        $arr = array($s, "", "");
    } else {
        $arr = array(substr($s, 0, $pos), $p, substr($s, $pos + strlen($p)));
    }
    $part_one = strlen($arr[0]);
    $part_two = strlen($arr[1]);
    $part_three = strlen($arr[2]);
    if ($part_one >= 2 && $part_two <= 2 && $part_three >= 2) {
        return strrev($arr[0]) . $arr[1] . strrev($arr[2]) . '#';
    }
    return $arr[0] . $arr[1] . $arr[2];
}

function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate("qqqqq", "qqq") !== "qqqqq") { throw new Exception("Test failed!"); }
}

test();

<?php
function f($text) {
    $dic = array();
    foreach (str_split($text) as $char) {
        $dic[$char] = isset($dic[$char]) ? $dic[$char] + 1 : 1;
    }
    foreach ($dic as $key => $value) {
        if ($value > 1) {
            $dic[$key] = 1;
        }
    }
    return $dic;
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate("a") !== array("a" => 1)) { throw new Exception("Test failed!"); }
}

test();

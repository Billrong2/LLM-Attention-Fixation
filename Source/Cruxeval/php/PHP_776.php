<?php
function f($dictionary) {
    $a = $dictionary;
    foreach($a as $key => $value) {
        if($key % 2 != 0) {
            unset($a[$key]);
            $a['$' . $key] = $a[$key];
        }
    }
    return $a;
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate(array()) !== array()) { throw new Exception("Test failed!"); }
}

test();

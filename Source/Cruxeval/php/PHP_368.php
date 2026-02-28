<?php
function f($string, $numbers) {
    $arr = [];
    foreach ($numbers as $num) {
        $arr[] = str_pad($string, $num, '0', STR_PAD_LEFT);
    }
    return implode(' ', $arr);
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate("4327", array(2, 8, 9, 2, 7, 1)) !== "4327 00004327 000004327 4327 0004327 4327") { throw new Exception("Test failed!"); }
}

test();

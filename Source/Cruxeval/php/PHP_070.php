<?php
function f($x) {
    $a = 0;
    $words = explode(' ', $x);
    foreach ($words as $word) {
        $a += strlen(str_pad($word, strlen($word)*2, '0', STR_PAD_LEFT));
    }
    return $a;
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate("999893767522480") !== 30) { throw new Exception("Test failed!"); }
}

test();

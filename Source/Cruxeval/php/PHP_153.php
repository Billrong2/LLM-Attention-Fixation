<?php
function f($text, $suffix, $num) {
    $str_num = strval($num);
    return substr($text, -strlen($suffix.$str_num)) === $suffix.$str_num;
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate("friends and love", "and", 3) !== false) { throw new Exception("Test failed!"); }
}

test();

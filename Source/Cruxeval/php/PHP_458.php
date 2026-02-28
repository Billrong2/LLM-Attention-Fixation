<?php
function f($text, $search_chars, $replace_chars) {
    $trans_table = array_combine(str_split($search_chars), str_split($replace_chars));
    return strtr($text, $trans_table);
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate("mmm34mIm", "mm3", ",po") !== "pppo4pIp") { throw new Exception("Test failed!"); }
}

test();

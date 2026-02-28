<?php
function f($text, $length, $fillchar) {
    $size = strlen($text);
    if ($size >= $length) {
        return $text;
    }
    $pad_length = $length - $size;
    $left_pad = ceil($pad_length / 2);
    $right_pad = $pad_length - $left_pad;
    $repeat_fillchar = str_repeat($fillchar, $left_pad);
    return $repeat_fillchar . $text . str_repeat($fillchar, $right_pad);
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate("magazine", 25, ".") !== ".........magazine........") { throw new Exception("Test failed!"); }
}

test();

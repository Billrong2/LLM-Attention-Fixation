<?php
function f($text, $amount) {
    $length = strlen($text);
    $pre_text = '|';
    if ($amount >= $length) {
        $extra_space = $amount - $length;
        $pre_text .= str_repeat(' ', intval($extra_space / 2));
        return $pre_text . $text . $pre_text;
    }
    return $text;
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate("GENERAL NAGOOR", 5) !== "GENERAL NAGOOR") { throw new Exception("Test failed!"); }
}

test();

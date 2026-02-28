<?php
function f($s, $separator) {
    for ($i = 0; $i < strlen($s); $i++) {
        if ($s[$i] == $separator) {
            $new_s = str_split($s);
            $new_s[$i] = '/';
            return implode(' ', $new_s);
        }
    }
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate("h grateful k", " ") !== "h / g r a t e f u l   k") { throw new Exception("Test failed!"); }
}

test();

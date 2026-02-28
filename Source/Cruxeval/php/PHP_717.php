<?php
function f($text) {
    $k = 0;
    $l = strlen($text) - 1;
    while (!ctype_alpha($text[$l])) {
        $l--;
    }
    while (!ctype_alpha($text[$k])) {
        $k++;
    }
    if ($k != 0 || $l != strlen($text) - 1) {
        return substr($text, $k, $l - $k + 1);
    } else {
        return $text[0];
    }
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate("timetable, 2mil") !== "t") { throw new Exception("Test failed!"); }
}

test();

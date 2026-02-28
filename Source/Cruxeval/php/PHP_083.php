<?php
function f($text) {
    $l = strrpos($text, '0');
    if ($l === false) {
        return '-1:-1';
    }
    $len_l = strlen(substr($text, 0, $l));
    $text_after_0 = substr($text, $l);
    $position_0 = strpos($text_after_0, '0');
    return $len_l . ':' . ($position_0 !== false ? $position_0 : '-1');
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate("qq0tt") !== "2:0") { throw new Exception("Test failed!"); }
}

test();

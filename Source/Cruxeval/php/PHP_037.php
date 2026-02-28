<?php
function f($text) {
    $text_arr = [];
    for ($j = 0; $j < strlen($text); $j++) {
        $text_arr[] = substr($text, $j);
    }
    return $text_arr;
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate("123") !== array("123", "23", "3")) { throw new Exception("Test failed!"); }
}

test();

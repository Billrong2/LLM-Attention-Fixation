<?php
function f($text) {
    $result = '';
    $mid = intval((strlen($text) - 1) / 2);
    for ($i = 0; $i < $mid; $i++) {
        $result .= $text[$i];
    }
    for ($i = $mid; $i < strlen($text) - 1; $i++) {
        $result .= $text[$mid + strlen($text) - 1 - $i];
    }
    return str_pad($result, strlen($text), $text[-1], STR_PAD_RIGHT);
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate("eat!") !== "e!t!") { throw new Exception("Test failed!"); }
}

test();

<?php
function f($text, $value) {
    $text_list = str_split($text);
    $text_list[] = $value;
    return implode('', $text_list);
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate("bcksrut", "q") !== "bcksrutq") { throw new Exception("Test failed!"); }
}

test();

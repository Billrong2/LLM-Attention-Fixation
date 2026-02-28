<?php
function f($text) {
    $chars = [];
    for ($i = 0; $i < strlen($text); $i++) {
        if (is_numeric($text[$i])) {
            $chars[] = $text[$i];
        }
    }
    return implode('', array_reverse($chars));
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate("--4yrw 251-//4 6p") !== "641524") { throw new Exception("Test failed!"); }
}

test();

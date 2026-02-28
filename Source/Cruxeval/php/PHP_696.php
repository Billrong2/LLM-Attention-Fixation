<?php
function f($text) {
    $s = 0;
    for ($i = 1; $i < strlen($text); $i++) {
        $s += strlen(substr($text, 0, strrpos($text, $text[$i])));
    }
    return $s;
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate("wdj") !== 3) { throw new Exception("Test failed!"); }
}

test();

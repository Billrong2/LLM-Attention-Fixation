<?php
function f($text) {
    $length = strlen($text);
    $index = 0;
    while ($index < $length && ctype_space($text[$index])) {
        $index++;
    }
    return substr($text, $index, 5);
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate("-----	\n	th\n-----") !== "-----") { throw new Exception("Test failed!"); }
}

test();

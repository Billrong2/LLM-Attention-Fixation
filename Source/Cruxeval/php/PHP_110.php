<?php
function f($text) {
    $a = [''];
    $b = '';
    for ($i = 0; $i < strlen($text); $i++) {
        if (!ctype_space($text[$i])) {
            $a[] = $b;
            $b = '';
        } else {
            $b .= $text[$i];
        }
    }
    return count($a);
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate("       ") !== 1) { throw new Exception("Test failed!"); }
}

test();

<?php
function f($text) {
    $ls = str_split($text);
    $total = (strlen($text) - 1) * 2;
    for ($i = 1; $i <= $total; $i++) {
        if ($i % 2) {
            $ls[] = '+';
        } else {
            array_unshift($ls, '+');
        }
    }
    return str_pad(implode('', $ls), $total, ' ', STR_PAD_LEFT);
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate("taole") !== "++++taole++++") { throw new Exception("Test failed!"); }
}

test();

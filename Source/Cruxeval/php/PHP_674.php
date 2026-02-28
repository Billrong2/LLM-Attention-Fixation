<?php
function f($text) {
    $ls = str_split($text);
    for ($x = count($ls) - 1; $x >= 0; $x--) {
        if (count($ls) <= 1) break;
        if (strpos('zyxwvutsrqponmlkjihgfedcba', $ls[$x]) === false) {
            array_splice($ls, $x, 1);
        }
    }
    return implode('', $ls);
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate("qq") !== "qq") { throw new Exception("Test failed!"); }
}

test();

<?php
function f($text, $n) {
    if ($n < 0 || strlen($text) <= $n) {
        return $text;
    }
    $result = substr($text, 0, $n);
    $i = strlen($result) - 1;
    while ($i >= 0) {
        if ($result[$i] !== $text[$i]) {
            break;
        }
        $i--;
    }
    return substr($text, 0, $i + 1);
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate("bR", -1) !== "bR") { throw new Exception("Test failed!"); }
}

test();

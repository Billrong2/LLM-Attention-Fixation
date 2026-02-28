<?php
function f($text, $substr, $occ) {
    $n = 0;
    while (true) {
        $i = strrpos($text, $substr);
        if ($i === false) {
            break;
        } elseif ($n === $occ) {
            return $i;
        } else {
            $n++;
            $text = substr($text, 0, $i);
        }
    }
    return -1;
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate("zjegiymjc", "j", 2) !== -1) { throw new Exception("Test failed!"); }
}

test();

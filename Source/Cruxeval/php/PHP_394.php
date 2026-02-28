<?php
function f($text) {
    $k = explode("\n", $text);
    $i = 0;
    foreach ($k as $j) {
        if (strlen($j) == 0) {
            return $i;
        }
        $i++;
    }
    return -1;
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate("2 m2 \n\nbike") !== 1) { throw new Exception("Test failed!"); }
}

test();

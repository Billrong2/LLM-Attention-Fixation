<?php
function f($base, $delta) {
    foreach ($delta as $d) {
        foreach ($base as $key => $value) {
            if ($value == $d[0]) {
                if ($d[1] != $value) {
                    $base[$key] = $d[1];
                }
            }
        }
    }
    return $base;
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate(array("gloss", "banana", "barn", "lawn"), array()) !== array("gloss", "banana", "barn", "lawn")) { throw new Exception("Test failed!"); }
}

test();

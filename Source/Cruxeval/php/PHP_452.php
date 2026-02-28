<?php
function f($text) {
    $counter = 0;
    for ($i = 0; $i < strlen($text); $i++) {
        if (ctype_alpha($text[$i])) {
            $counter++;
        }
    }
    return $counter;
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate("l000*") !== 1) { throw new Exception("Test failed!"); }
}

test();

<?php
function f($text) {
    $n = 0;
    for ($i = 0; $i < strlen($text); $i++) {
        if (ctype_upper($text[$i])) {
            $n += 1;
        }
    }
    return $n;
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate("AAAAAAAAAAAAAAAAAAAA") !== 20) { throw new Exception("Test failed!"); }
}

test();

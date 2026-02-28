<?php
function f($s) {
    $count = strlen($s) - 1;
    $reverse_s = strrev($s);
    while ($count > 0 && strrpos(substr($reverse_s, 0, $count), 'sea') === false) {
        $count -= 1;
        $reverse_s = substr($reverse_s, 0, $count);
    }
    return substr($reverse_s, $count);
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate("s a a b s d s a a s a a") !== "") { throw new Exception("Test failed!"); }
}

test();

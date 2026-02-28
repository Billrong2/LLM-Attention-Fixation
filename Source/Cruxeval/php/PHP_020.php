<?php
function f($text) {
    $result = '';
    for ($i = strlen($text) - 1; $i >= 0; $i--) {
        $result .= $text[$i];
    }
    return $result;
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate("was,") !== ",saw") { throw new Exception("Test failed!"); }
}

test();

<?php
function f($string) {
    $tmp = strtolower($string);
    foreach (str_split(strtolower($string)) as $char) {
        if (strpos($tmp, $char) !== false) {
            $tmp = preg_replace('/' . preg_quote($char, '/') . '/', '', $tmp, 1);
        }
    }
    return $tmp;
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate("[ Hello ]+ Hello, World!!_ Hi") !== "") { throw new Exception("Test failed!"); }
}

test();

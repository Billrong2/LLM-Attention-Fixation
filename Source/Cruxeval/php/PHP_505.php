<?php
function f($string) {
    while ($string) {
        if (ctype_alpha(substr($string, -1))) {
            return $string;
        }
        $string = substr($string, 0, -1);
    }
    return $string;
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate("--4/0-209") !== "") { throw new Exception("Test failed!"); }
}

test();

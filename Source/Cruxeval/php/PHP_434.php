<?php
function f($string) {
    try {
        return strrpos($string, 'e');
    } catch (Exception $e) {
        return "Nuk";
    }
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate("eeuseeeoehasa") !== 8) { throw new Exception("Test failed!"); }
}

test();

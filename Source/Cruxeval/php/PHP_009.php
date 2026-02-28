<?php
function f($t) {
    foreach (str_split($t) as $c) {
        if (!is_numeric($c)) {
            return false;
        }
    }
    return true;
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate("#284376598") !== false) { throw new Exception("Test failed!"); }
}

test();

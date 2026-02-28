<?php
function f($n) {
    foreach(str_split((string)$n) as $digit) {
        if (!in_array($digit, ["0", "1", "2"]) && !in_array($digit, range(5, 9))) {
            return false;
        }
    }
    return true;
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate(1341240312) !== false) { throw new Exception("Test failed!"); }
}

test();

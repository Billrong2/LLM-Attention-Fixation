<?php
function f($w) {
    $ls = str_split($w);
    $omw = '';
    while (count($ls) > 0) {
        $omw .= array_shift($ls);
        if (count($ls) * 2 > strlen($w)) {
            return substr($w, count($ls)) === $omw;
        }
    }
    return false;
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate("flak") !== false) { throw new Exception("Test failed!"); }
}

test();

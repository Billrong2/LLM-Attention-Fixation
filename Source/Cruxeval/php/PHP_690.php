<?php
function f($n) {
    if (strpos(strval($n), '.') !== false) {
        return strval(intval($n) + 2.5);
    }
    return strval($n);
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate("800") !== "800") { throw new Exception("Test failed!"); }
}

test();

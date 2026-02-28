<?php
function f($x) {
    if (ctype_lower($x)) {
        return $x;
    } else {
        return strrev($x);
    }
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate("ykdfhp") !== "ykdfhp") { throw new Exception("Test failed!"); }
}

test();

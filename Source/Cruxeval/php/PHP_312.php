<?php
function f($s) {
    if (ctype_alnum($s)) {
        return "True";
    }
    return "False";
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate("777") !== "True") { throw new Exception("Test failed!"); }
}

test();

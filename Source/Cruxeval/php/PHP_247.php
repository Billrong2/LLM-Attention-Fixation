<?php
function f($s) {
    if (ctype_alpha($s)) {
        return "yes";
    }
    if ($s === "") {
        return "str is empty";
    }
    return "no";
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate("Boolean") !== "yes") { throw new Exception("Test failed!"); }
}

test();

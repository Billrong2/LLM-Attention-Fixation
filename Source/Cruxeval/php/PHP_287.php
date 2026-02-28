<?php
function f($name) {
    if (ctype_lower($name)) {
        $name = strtoupper($name);
    } else {
        $name = strtolower($name);
    }
    return $name;
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate("Pinneaple") !== "pinneaple") { throw new Exception("Test failed!"); }
}

test();

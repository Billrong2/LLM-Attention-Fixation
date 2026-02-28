<?php
function f($challenge) {
    return str_replace('l', ',', strtolower($challenge));
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate("czywZ") !== "czywz") { throw new Exception("Test failed!"); }
}

test();

<?php
function f($values, $text, $markers) {
    return rtrim(rtrim($text, $values), $markers);
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate("2Pn", "yCxpg2C2Pny2", "") !== "yCxpg2C2Pny") { throw new Exception("Test failed!"); }
}

test();

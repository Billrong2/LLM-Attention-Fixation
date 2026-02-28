<?php
function f($text) {
    return implode(' ', array_map('ltrim', explode(' ', $text)));
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate("pvtso") !== "pvtso") { throw new Exception("Test failed!"); }
}

test();

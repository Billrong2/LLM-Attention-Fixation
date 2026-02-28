<?php
function f($n) {
    $length = strlen($n) + 2;
    $revn = str_split($n);
    $result = implode('', $revn);
    $revn = array();
    return $result . str_repeat('!', $length);
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate("iq") !== "iq!!!!") { throw new Exception("Test failed!"); }
}

test();

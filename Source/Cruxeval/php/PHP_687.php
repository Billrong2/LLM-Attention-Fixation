<?php
function f($text) {
    $t = str_split($text);
    array_splice($t, intval(count($t) / 2), 1);
    $t[] = strtolower($text);
    return implode(':', $t);
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate("Rjug nzufE") !== "R:j:u:g: :z:u:f:E:rjug nzufe") { throw new Exception("Test failed!"); }
}

test();

<?php
function f($float_number) {
    $number = strval($float_number);
    $dot = strpos($number, '.');
    if ($dot !== false) {
        return substr($number, 0, $dot) . '.' . str_pad(substr($number, $dot+1), 2, '0', STR_PAD_RIGHT);
    }
    return $number . '.00';
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate(3.121) !== "3.121") { throw new Exception("Test failed!"); }
}

test();

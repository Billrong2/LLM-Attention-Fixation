<?php
function f($s, $from_c, $to_c) {
    $table = array_combine(str_split($from_c), str_split($to_c));
    return strtr($s, $table);
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate("aphid", "i", "?") !== "aph?d") { throw new Exception("Test failed!"); }
}

test();

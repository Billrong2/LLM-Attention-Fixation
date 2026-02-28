<?php
function f($text, $char) {
    $count = substr_count($text, $char.$char);
    return substr($text, $count);
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate("vzzv2sg", "z") !== "zzv2sg") { throw new Exception("Test failed!"); }
}

test();

<?php
function f($string, $sep) {
    $cnt = substr_count($string, $sep);
    return strrev(str_repeat($string . $sep, $cnt));
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate("caabcfcabfc", "ab") !== "bacfbacfcbaacbacfbacfcbaac") { throw new Exception("Test failed!"); }
}

test();

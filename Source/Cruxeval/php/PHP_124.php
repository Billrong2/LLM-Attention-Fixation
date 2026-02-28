<?php
function f($txt, $sep, $sep_count) {
    $o = '';
    while ($sep_count > 0 && substr_count($txt, $sep) > 0) {
        $parts = explode($sep, $txt);
        $o .= $parts[0] . $sep;
        $txt = end($parts);
        $sep_count--;
    }
    return $o . $txt;
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate("i like you", " ", -1) !== "i like you") { throw new Exception("Test failed!"); }
}

test();

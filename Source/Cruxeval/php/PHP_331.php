<?php
function f($strand, $zmnc) {
    $poz = strpos($strand, $zmnc);
    while ($poz !== false) {
        $strand = substr($strand, $poz + 1);
        $poz = strpos($strand, $zmnc);
    }
    return strrpos($strand, $zmnc) ?: -1;
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate("", "abc") !== -1) { throw new Exception("Test failed!"); }
}

test();

<?php
function f($string) {
    $l = str_split($string);
    for ($i = count($l) - 1; $i >= 0; $i--) {
        if ($l[$i] != ' ') {
            break;
        }
        unset($l[$i]);
    }
    return implode('', $l);
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate("    jcmfxv     ") !== "    jcmfxv") { throw new Exception("Test failed!"); }
}

test();

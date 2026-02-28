<?php
function f($chars) {
    $s = "";
    foreach (str_split($chars) as $ch) {
        if (substr_count($chars, $ch) % 2 == 0) {
            $s .= strtoupper($ch);
        } else {
            $s .= $ch;
        }
    }
    return $s;
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate("acbced") !== "aCbCed") { throw new Exception("Test failed!"); }
}

test();

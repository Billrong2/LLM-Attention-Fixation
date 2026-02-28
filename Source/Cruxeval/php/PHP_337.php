<?php
function f($txt) {
    $d = [];
    for ($i = 0; $i < strlen($txt); $i++) {
        $c = $txt[$i];
        if (is_numeric($c)) {
            continue;
        }
        if (ctype_lower($c)) {
            $d[] = strtoupper($c);
        } elseif (ctype_upper($c)) {
            $d[] = strtolower($c);
        }
    }
    return implode('', $d);
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate("5ll6") !== "LL") { throw new Exception("Test failed!"); }
}

test();

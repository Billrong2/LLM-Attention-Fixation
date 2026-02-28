<?php
function f($alphabet, $s) {
    $a = [];
    foreach(str_split($alphabet) as $x) {
        if (strpos($s, strtoupper($x)) !== false) {
            $a[] = $x;
        }
    }

    if (strtoupper($s) === $s) {
        $a[] = 'all_uppercased';
    }

    return $a;
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate("abcdefghijklmnopqrstuvwxyz", "uppercased # % ^ @ ! vz.") !== array()) { throw new Exception("Test failed!"); }
}

test();

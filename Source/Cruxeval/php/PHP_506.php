<?php
function f($n) {
    $p = '';
    if ($n % 2 == 1) {
        $p .= 'sn';
    } else {
        return $n * $n;
    }
    for ($x = 1; $x <= $n; $x++) {
        if ($x % 2 == 0) {
            $p .= 'to';
        } else {
            $p .= 'ts';
        }
    }
    return $p;
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate(1) !== "snts") { throw new Exception("Test failed!"); }
}

test();

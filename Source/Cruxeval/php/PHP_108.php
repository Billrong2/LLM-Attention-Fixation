<?php
function f($var) {
    if (is_array($var)) {
        $amount = count($var);
    } elseif (is_array($var) && is_assoc($var)) {
        $amount = count($var);
    } else {
        $amount = 0;
    }

    $nonzero = $amount > 0 ? $amount : 0;
    return $nonzero;
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate(1) !== 0) { throw new Exception("Test failed!"); }
}

test();

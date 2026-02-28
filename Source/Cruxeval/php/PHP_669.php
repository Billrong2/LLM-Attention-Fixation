<?php
function f($t) {
    list($a, $sep, $b) = explode('-', $t, 3);
    if (strlen($b) == strlen($a)) {
        return 'imbalanced';
    }
    return $a . str_replace($sep, '', $b);
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate("fubarbaz") !== "fubarbaz") { throw new Exception("Test failed!"); }
}

test();

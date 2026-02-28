<?php
function f($x, $y) {
    $tmp = strrev(str_replace('9', '0', str_replace('0', '9', $y)));
    if (is_numeric($x) && is_numeric($tmp)) {
        return $x . $tmp;
    } else {
        return $x;
    }
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate("", "sdasdnakjsda80") !== "") { throw new Exception("Test failed!"); }
}

test();

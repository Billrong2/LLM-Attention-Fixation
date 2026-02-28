<?php
function f($st) {
    if ($st[0] == '~') {
        $e = str_pad($st, 10, 's', STR_PAD_LEFT);
        return f($e);
    } else {
        return str_pad($st, 10, 'n', STR_PAD_LEFT);
    }
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate("eqe-;ew22") !== "neqe-;ew22") { throw new Exception("Test failed!"); }
}

test();

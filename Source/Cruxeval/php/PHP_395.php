<?php
function f($s) {
    for ($i = 0; $i < strlen($s); $i++) {
        if (is_numeric($s[$i])) {
            return $i + ($s[$i] == '0');
        } elseif ($s[$i] == '0') {
            return -1;
        }
    }
    return -1;
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate("11") !== 0) { throw new Exception("Test failed!"); }
}

test();

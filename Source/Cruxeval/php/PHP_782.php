<?php
function f($input) {
    for ($i = 0; $i < strlen($input); $i++) {
        if (ctype_upper($input[$i])) {
            return false;
        }
    }
    return true;
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate("a j c n x X k") !== false) { throw new Exception("Test failed!"); }
}

test();

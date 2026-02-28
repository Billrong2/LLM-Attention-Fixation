<?php
function f($string) {
    $upper = 0;
    for ($i = 0; $i < strlen($string); $i++) {
        if (ctype_upper($string[$i])) {
            $upper += 1;
        }
    }
    return $upper * (2 - ($upper % 2));
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate("PoIOarTvpoead") !== 8) { throw new Exception("Test failed!"); }
}

test();

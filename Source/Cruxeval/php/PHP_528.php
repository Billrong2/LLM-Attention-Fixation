<?php
function f($s) {
    $b = '';
    $c = '';
    for ($i = 0; $i < strlen($s); $i++) {
        $c = $c . $s[$i];
        if (strrpos($s, $c) !== false) {
            return strrpos($s, $c);
        }
    }
    return 0;
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate("papeluchis") !== 2) { throw new Exception("Test failed!"); }
}

test();

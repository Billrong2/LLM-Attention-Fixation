<?php
function f($s) {
    $r = [];
    for ($i = strlen($s) - 1; $i >= 0; $i--) {
        $r[] = $s[$i];
    }
    return implode('', $r);
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate("crew") !== "werc") { throw new Exception("Test failed!"); }
}

test();

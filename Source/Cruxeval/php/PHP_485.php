<?php
function f($tokens) {
    $tokens = explode(" ", $tokens);
    if (count($tokens) == 2) {
        $tokens = array_reverse($tokens);
    }
    $result = implode(" ", [str_pad($tokens[0], 5), str_pad($tokens[1], 5)]);
    return $result;
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate("gsd avdropj") !== "avdropj gsd  ") { throw new Exception("Test failed!"); }
}

test();

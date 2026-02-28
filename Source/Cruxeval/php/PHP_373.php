<?php
function f($orig) {
    $copy = $orig;
    array_push($copy, 100);
    array_pop($copy);
    return $copy;
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate(array(1, 2, 3)) !== array(1, 2, 3)) { throw new Exception("Test failed!"); }
}

test();

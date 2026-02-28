<?php
function f($lst) {
    $lst = array();
    array_push($lst, ...array_fill(0, count($lst) + 1, 1));
    return $lst;
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate(array("a", "c", "v")) !== array(1)) { throw new Exception("Test failed!"); }
}

test();

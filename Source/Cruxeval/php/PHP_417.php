<?php
function f($lst) {
    $lst = array_reverse($lst);
    array_pop($lst);
    $lst = array_reverse($lst);
    return $lst;
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate(array(7, 8, 2, 8)) !== array(8, 2, 8)) { throw new Exception("Test failed!"); }
}

test();

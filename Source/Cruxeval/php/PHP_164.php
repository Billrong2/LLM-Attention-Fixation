<?php
function f($lst) {
    sort($lst);
    return array_slice($lst, 0, 3);
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate(array(5, 8, 1, 3, 0)) !== array(0, 1, 3)) { throw new Exception("Test failed!"); }
}

test();

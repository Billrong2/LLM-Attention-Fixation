<?php
function f($values) {
    sort($values);
    return $values;
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate(array(1, 1, 1, 1)) !== array(1, 1, 1, 1)) { throw new Exception("Test failed!"); }
}

test();

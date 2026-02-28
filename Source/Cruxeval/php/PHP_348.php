<?php
function f($dictionary) {
    return $dictionary;
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate(array(563 => 555, 133 => null)) !== array(563 => 555, 133 => null)) { throw new Exception("Test failed!"); }
}

test();

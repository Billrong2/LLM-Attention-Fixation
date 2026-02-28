<?php
function f(&$nums) {
    $nums = array();
    return "quack";
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate(array(2, 5, 1, 7, 9, 3)) !== "quack") { throw new Exception("Test failed!"); }
}

test();

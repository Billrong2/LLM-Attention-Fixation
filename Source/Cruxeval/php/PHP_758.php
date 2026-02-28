<?php
function f($nums) {
    if (array_reverse($nums) == $nums) {
        return true;
    }
    return false;
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate(array(0, 3, 6, 2)) !== false) { throw new Exception("Test failed!"); }
}

test();

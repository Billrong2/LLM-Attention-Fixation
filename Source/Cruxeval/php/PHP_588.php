<?php
function f($items, $target) {
    if (in_array($target, $items)) {
        return array_search($target, $items);
    }
    return -1;
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate(array("1", "+", "-", "**", "//", "*", "+"), "**") !== 3) { throw new Exception("Test failed!"); }
}

test();

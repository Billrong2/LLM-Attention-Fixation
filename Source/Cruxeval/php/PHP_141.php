<?php
function f($li) {
    return array_map(function ($i) use ($li) {
        return array_count_values($li)[$i];
    }, $li);
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate(array("k", "x", "c", "x", "x", "b", "l", "f", "r", "n", "g")) !== array(1, 3, 1, 3, 3, 1, 1, 1, 1, 1, 1)) { throw new Exception("Test failed!"); }
}

test();

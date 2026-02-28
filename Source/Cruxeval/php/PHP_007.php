<?php
function f($list) {
    $original = $list;
    while (count($list) > 1) {
        array_pop($list);
        for ($i = 0; $i < count($list); $i++) {
            array_splice($list, $i, 1);
        }
    }
    $list = $original;
    if ($list) {
        array_shift($list);
    }
    return $list;
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate(array()) !== array()) { throw new Exception("Test failed!"); }
}

test();

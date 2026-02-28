<?php
function f($nums, $elements) {
    $result = [];
    foreach ($elements as $element) {
        $result[] = array_pop($nums);
    }
    return $nums;
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate(array(7, 1, 2, 6, 0, 2), array(9, 0, 3)) !== array(7, 1, 2)) { throw new Exception("Test failed!"); }
}

test();

<?php
function f($nums) {
    $l = array();
    foreach ($nums as $i) {
        if (!in_array($i, $l)) {
            $l[] = $i;
        }
    }
    return $l;
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate(array(3, 1, 9, 0, 2, 0, 8)) !== array(3, 1, 9, 0, 2, 8)) { throw new Exception("Test failed!"); }
}

test();

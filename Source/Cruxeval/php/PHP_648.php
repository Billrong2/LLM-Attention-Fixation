<?php
function f($list1, $list2) {
    $l = $list1;
    while (count($l) > 0) {
        if (in_array(end($l), $list2)) {
            array_pop($l);
        } else {
            return end($l);
        }
    }
    return 'missing';
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate(array(0, 4, 5, 6), array(13, 23, -5, 0)) !== 6) { throw new Exception("Test failed!"); }
}

test();

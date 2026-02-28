<?php
function f($array, $elem) {
    foreach ($elem as $item) {
        $array[] = $item;
    }
    return $array;
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate(array(array(1, 2, 3), array(1, 2), 1), array(array(1, 2, 3), 3, array(2, 1))) !== array(array(1, 2, 3), array(1, 2), 1, array(1, 2, 3), 3, array(2, 1))) { throw new Exception("Test failed!"); }
}

test();

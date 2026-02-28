<?php
function f($lst) {
    $sliced_lst = array_slice($lst, 1, 3);
    $sliced_lst = array_reverse($sliced_lst);
    $lst = array_merge(array_slice($lst, 0, 1), $sliced_lst, array_slice($lst, 4));
    return $lst;
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate(array(1, 2, 3)) !== array(1, 3, 2)) { throw new Exception("Test failed!"); }
}

test();

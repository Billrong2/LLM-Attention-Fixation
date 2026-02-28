<?php
function f($mylist) {
    $revl = $mylist;
    $reversed = array_reverse($revl);
    rsort($mylist);
    return $mylist == $reversed;
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate(array(5, 8)) !== true) { throw new Exception("Test failed!"); }
}

test();

<?php
function f($in_list, $num) {
    array_push($in_list, $num);
    return array_search(max(array_slice($in_list, 0, count($in_list) - 1)), $in_list);
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate(array(-1, 12, -6, -2), -1) !== 1) { throw new Exception("Test failed!"); }
}

test();

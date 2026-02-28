<?php
function f($nums, $delete) {
    $key = array_search($delete, $nums);
    if($key !== false){
        unset($nums[$key]);
    }
    return array_values($nums);
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate(array(4, 5, 3, 6, 1), 5) !== array(4, 3, 6, 1)) { throw new Exception("Test failed!"); }
}

test();

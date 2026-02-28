<?php
function f($base_list, $nums) {
    $base_list = array_merge($base_list, $nums);
    $res = $base_list;
    for ($i = -1 * count($nums); $i < 0; $i++) {
        array_push($res, $res[count($res) + $i]);
    }
    return $res;
}

function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate(array(9, 7, 5, 3, 1), array(2, 4, 6, 8, 0)) !== array(9, 7, 5, 3, 1, 2, 4, 6, 8, 0, 2, 6, 0, 6, 6)) { throw new Exception("Test failed!"); }
}

test();

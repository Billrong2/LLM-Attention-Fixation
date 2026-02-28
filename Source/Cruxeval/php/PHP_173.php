<?php
function f($list_x) {
    $item_count = count($list_x);
    $new_list = [];
    for ($i = 0; $i < $item_count; $i++) {
        array_push($new_list, array_pop($list_x));
    }
    return $new_list;
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate(array(5, 8, 6, 8, 4)) !== array(4, 8, 6, 8, 5)) { throw new Exception("Test failed!"); }
}

test();

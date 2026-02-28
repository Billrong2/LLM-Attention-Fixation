<?php
function f($nums, $val) {
    $new_list = array();
    foreach ($nums as $i) {
        for ($j = 0; $j < $val; $j++) {
            $new_list[] = $i;
        }
    }
    return array_sum($new_list);
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate(array(10, 4), 3) !== 42) { throw new Exception("Test failed!"); }
}

test();

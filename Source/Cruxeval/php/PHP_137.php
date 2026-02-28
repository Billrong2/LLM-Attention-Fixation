<?php
function f($nums) {
    $count = 0;
    foreach ($nums as $key => $value) {
        if (empty($nums)) {
            break;
        }
        if ($count % 2 == 0) {
            array_pop($nums);
        } else {
            array_shift($nums);
        }
        $count++;
    }
    return $nums;
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate(array(3, 2, 0, 0, 2, 3)) !== array()) { throw new Exception("Test failed!"); }
}

test();
